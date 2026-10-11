/**
 * One call to Anthropic's Messages API that must answer through a single tool.
 * Newer models refuse a forced tool, so the prompt asks for it and tool_choice is "auto";
 * a JSON object in a text reply is accepted too. Request bodies are never logged.
 */
const MESSAGES = 'https://api.anthropic.com/v1/messages';

export class ModelError extends Error {
  constructor(message, { retryable }) {
    super(message);
    this.retryable = retryable;
  }
}

export async function structured({ system, user, toolName, schema, model, apiKey, fetchImpl = fetch }) {
  if (!apiKey) throw new ModelError('ANTHROPIC_API_KEY is not set on the workflow', { retryable: false });
  const response = await fetchImpl(MESSAGES, {
    method: 'POST',
    headers: { 'x-api-key': apiKey, 'anthropic-version': '2023-06-01', 'content-type': 'application/json' },
    body: JSON.stringify({
      model,
      max_tokens: 1500,
      system: `${system}\n\nAlways answer by calling the ${toolName} tool, and nothing else.`,
      messages: [{ role: 'user', content: user }],
      tools: [{ name: toolName, description: 'Return the result for the person to review.', input_schema: schema }],
      tool_choice: { type: 'auto' },
    }),
    signal: AbortSignal.timeout(45_000),
  });
  const body = await response.json().catch(() => ({}));
  if (!response.ok) {
    const detail = `${response.status} ${body?.error?.type ?? ''}: ${body?.error?.message ?? ''}`.slice(0, 300);
    // Rate limits and overloads are worth retrying; a bad key or bad request is not.
    throw new ModelError(detail, { retryable: response.status === 429 || response.status >= 500 });
  }
  const content = body.content ?? [];
  const tool = content.find((b) => b.type === 'tool_use' && b.name === toolName);
  if (tool) return tool.input;
  for (const b of content) {
    const text = b.type === 'text' ? b.text : '';
    const start = text.indexOf('{');
    const end = text.lastIndexOf('}');
    if (start >= 0 && end > start) {
      try {
        return JSON.parse(text.slice(start, end + 1));
      } catch {
        // try the next block
      }
    }
  }
  throw new ModelError('no tool answer in the reply', { retryable: true });
}
