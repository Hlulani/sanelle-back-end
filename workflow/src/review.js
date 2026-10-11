/** The second, independent pass: a fresh model call that only removes, never adds or rewrites. */
export const REVIEW_SYSTEM = `You are a careful reviewer for Sanelle, an app that helps a person with uterine fibroids \
prepare for appointments. You are given her data (counts and her own notes) and a draft written by another model.

Remove every item that breaks a rule. Do not add items and do not rewrite wording; keep or remove only.
Remove an item if it:
- uses a number, date or count that is not in her facts or notes;
- names a diagnosis or a cause, suggests or judges a treatment, or predicts anything;
- quotes words that are not copied exactly from her notes;
- matches an explanation that is not directly about what the quote describes;
- repeats a question she already saved.
If the brief breaks a rule, return an empty brief. For each removal, give a short reason.`;

export const REVIEW_SCHEMA = {
  type: 'object',
  required: ['keepBrief', 'keepQuestions', 'keepMatches', 'removed'],
  properties: {
    keepBrief: { type: 'boolean' },
    keepQuestions: { type: 'array', items: { type: 'integer' }, description: '0-based indexes of questions to keep' },
    keepMatches: { type: 'array', items: { type: 'integer' }, description: '0-based indexes of matches to keep' },
    removed: { type: 'array', items: { type: 'string' }, description: 'One short reason per removed item' },
  },
};

export function reviewPrompt(user, draft) {
  return `${user}\n\nDraft to review (indexes are 0-based):\n${JSON.stringify(draft, null, 2)}`;
}

/** Applies the reviewer's decisions. Unknown indexes are ignored, so the reviewer can only remove. */
export function applyReview(draft, review) {
  const keep = (items, indexes) =>
    (items ?? []).filter((_, i) => Array.isArray(indexes) && indexes.includes(i));
  return {
    brief: review?.keepBrief ? (draft?.brief ?? '') : '',
    questions: keep(draft?.questions, review?.keepQuestions),
    matches: keep(draft?.matches, review?.keepMatches),
  };
}
