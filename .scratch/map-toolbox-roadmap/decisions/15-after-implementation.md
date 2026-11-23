# After implementation: from merged PR to closed loop

Type: grilling
Status: open
Blocked by: 13

## Question

What happens after `/ship`: PR review and CI, merge, what `/end-session` updates, what happens to the spec folder and its work tickets (archive, or fold into living docs as OpenSpec does), lessons to the vault (link to 10), branch cleanup, and release or deploy where a project has one? Which parts belong in `/ship`, `/end-session` or a new step?

## Merged in: 24, leaner /ship and /end-session (2026-11-23)

Goal: as few PRs as a session needs and fewer tokens. Points carried over:

1. **One branch per session:** one working branch and PR for a session's notes and docs changes, shipped once; what still splits PRs (code vs docs, merge types). Ship / Show / Ask (research 29) as the model: notes Ship or Show, `skills/`, `tools/`, `templates/` Ask.
2. **Where the LOG line goes** once the session's PR has merged: a new PR, a direct commit to `main` for `docs/LOG.md` only, or the next session's first branch.
3. **Docs-only fast path:** skip parts of `/ship` (the `/pr` run, the full body) or auto-merge after CI ("GitHub personal mode" in `ideas.md`).
4. **Usage:** which steps of `/ship`, `/end-session` and `/start-session` cost the most tokens and can be trimmed (measure with 20's markers).
5. **When `/ship` is offered:** automatically, at session end only, or when asked.
6. **Cloud sessions** block GitHub GraphQL, so `/ship` needs a `gh api` fallback there (research 29).

Related: 30 (hooks back the session skills), 21.
