# Sanelle AI — Render Workflow

Every Sanelle AI draft runs as a multi-step Render Workflow:

1. **`draft_insights`**: Claude drafts a visit brief, questions and matched explanations from
   her check-in counts and her own notes.
2. **`review_insights`**: a second, independent Claude call reviews the draft against her data.
   It can only remove items, and gives a reason for each removal: a number not in her records, a
   diagnosis or cause, a quote she never wrote, a weak match.
3. **The API's rule checks** (`InsightsService` in the Java API) run last, before anything
   reaches her. The app checks once more on the device.

`sanelle_insights` chains steps 1 and 2. Each step retries on rate limits and overloads, but not
on bad requests. If the workflow isn't configured or fails, the API makes the draft directly,
so Sanelle AI keeps working.

## Deploy on Render

- New → Workflow, this repository, name **`sanelle-ai`**, language Node.
- Root directory `workflow`, build command `npm install`, start command `npm start`.
- Environment: `ANTHROPIC_API_KEY` (and optionally `ANTHROPIC_MODEL`).
- On the API service, set `RENDER_API_KEY` (a Render API key). The API runs the task
  `sanelle-ai/sanelle_insights`; `/api/v1/ai/status` shows which pipeline the last draft used.

## Test

```bash
npm install && npm test
```
