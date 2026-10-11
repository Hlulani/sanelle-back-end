import { test } from 'node:test';
import assert from 'node:assert/strict';
import { applyReview } from './review.js';
import { structured } from './anthropic.js';

const draft = {
  brief: 'My main concern: heavy bleeding.',
  questions: [{ text: 'A', why: 'a' }, { text: 'B', why: 'b' }],
  matches: [{ claimId: 'C36', quote: 'Flooding' }],
};

test('the reviewer can only remove items, never add them', () => {
  const out = applyReview(draft, { keepBrief: false, keepQuestions: [1, 7], keepMatches: [0], removed: ['x'] });
  assert.deepEqual(out, { brief: '', questions: [{ text: 'B', why: 'b' }], matches: draft.matches });
});

test('a missing or broken review keeps nothing', () => {
  assert.deepEqual(applyReview(draft, null), { brief: '', questions: [], matches: [] });
});

test('reads the tool answer, or JSON in a text reply', async () => {
  const reply = (content) => async () => ({ ok: true, json: async () => ({ content }) });
  const args = { system: 's', user: 'u', toolName: 't', schema: {}, model: 'm', apiKey: 'k' };
  assert.deepEqual(
    await structured({ ...args, fetchImpl: reply([{ type: 'tool_use', name: 't', input: { a: 1 } }]) }),
    { a: 1 },
  );
  assert.deepEqual(await structured({ ...args, fetchImpl: reply([{ type: 'text', text: 'Here: {"a":2}' }]) }), {
    a: 2,
  });
});

test('a bad request is not retried; an overload is', async () => {
  const fail = (status) => async () => ({ ok: false, status, json: async () => ({ error: { type: 'e', message: 'm' } }) });
  const args = { system: 's', user: 'u', toolName: 't', schema: {}, model: 'm', apiKey: 'k' };
  await assert.rejects(structured({ ...args, fetchImpl: fail(400) }), (e) => e.retryable === false);
  await assert.rejects(structured({ ...args, fetchImpl: fail(529) }), (e) => e.retryable === true);
});
