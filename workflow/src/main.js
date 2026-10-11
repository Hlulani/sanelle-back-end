import { task } from '@renderinc/sdk/workflows';
import { ModelError, structured } from './anthropic.js';
import { REVIEW_SCHEMA, REVIEW_SYSTEM, applyReview, reviewPrompt } from './review.js';

/**
 * Sanelle AI as a Render Workflow. The API sends the prompt it built from her check-ins; this
 * workflow drafts, then has a separate model call review the draft, and returns only what
 * survived. The API then applies its own rule checks before anything reaches her.
 */
const model = () => process.env.ANTHROPIC_MODEL || 'claude-sonnet-5-5';
const apiKey = () => (process.env.ANTHROPIC_API_KEY || '').trim();
const RETRY = { maxRetries: 2, waitDurationMs: 2000, backoffScaling: 2 };

async function call(args) {
  try {
    return await structured({ ...args, model: model(), apiKey: apiKey() });
  } catch (e) {
    // Non-retryable errors are reported without the stack, and never with the request.
    if (e instanceof ModelError && !e.retryable) throw new Error(`not retryable: ${e.message}`);
    throw e;
  }
}

/** Step 1: write the draft brief, questions and matches. */
export const draftInsights = task(
  { name: 'draft_insights', retry: RETRY, timeoutSeconds: 120 },
  async function draftInsights(ctx, prompt) {
    return call({ system: prompt.system, user: prompt.user, toolName: prompt.toolName, schema: prompt.schema });
  },
);

/** Step 2: an independent reviewer that can only remove items, with a reason for each. */
export const reviewInsights = task(
  { name: 'review_insights', retry: RETRY, timeoutSeconds: 120 },
  async function reviewInsights(ctx, prompt, draft) {
    const review = await call({
      system: REVIEW_SYSTEM,
      user: reviewPrompt(prompt.user, draft),
      toolName: 'record_review',
      schema: REVIEW_SCHEMA,
    });
    return { draft: applyReview(draft, review), removed: (review?.removed ?? []).slice(0, 10) };
  },
);

/** The entry point the API runs: sanelle-ai/sanelle_insights. */
task({ name: 'sanelle_insights', timeoutSeconds: 300 }, async function sanelleInsights(ctx, prompt) {
  const draft = await ctx.run(draftInsights, prompt);
  const reviewed = await ctx.run(reviewInsights, prompt, draft);
  return { ...reviewed.draft, review: { removed: reviewed.removed, steps: ['draft', 'review'] } };
});
