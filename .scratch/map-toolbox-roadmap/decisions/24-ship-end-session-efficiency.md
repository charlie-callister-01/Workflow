# Leaner /ship and /end-session: fewer PRs, less usage

Type: grilling
Status: open
Blocked by: none

## Question

How do `/ship` and `/end-session` change so a session produces as few PRs as it needs and spends fewer tokens? Today one session can open several small PRs: on 2026-11-23 the end-of-session LOG line went out as its own PR (#12) because the session's PR had already merged, and a decision ticket resolved afterwards opened another (#13). Each `/ship` also loads settings, runs `/mattpocock-skills:pr`, pushes and opens a PR, which costs usage and Charlie's review time.

Points to decide:

1. **One branch per session:** should a session keep one working branch and one PR for all its notes and docs changes (decision tickets, CHANGELOG, LOG), shipping once at the end, instead of a PR per change? What splits a session into separate PRs (code vs docs, different merge types)?
2. **Where the LOG line goes:** on the session's open PR (today's step 9), and when that PR has already merged: a new PR, a direct commit to `main` for `docs/LOG.md` only, or carried onto the next session's first branch?
3. **Docs-only fast path:** can notes/docs-only changes skip parts of `/ship` (the `/pr` skill run, the full body template) or auto-merge after CI (the "GitHub personal mode" idea in `ideas.md`)?
4. **Usage:** which steps in `/ship`, `/end-session` and `/start-session` cost the most tokens (reading whole files, subagent runs, repeated `git`/`gh` calls), and which can be trimmed or merged. Markers from 20 (session transcripts) can measure before and after.
5. **When to ship:** should `/ship` be offered automatically, at the end of the session only, or when the owner asks?

Related: 13 (change flows: a small change may not need its own PR), 15 (after implementation: what `/end-session` updates), 21 (measuring the workflow), ideas.md "GitHub personal mode".
