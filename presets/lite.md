# Preset: lite

For: a small personal project, a spike, or a weekend build. No phases, no vault, no boards.

## Pipeline

```
(optional) /mattpocock-skills:grilling   for the idea
  -> branch -> /mattpocock-skills:tdd or just build
  -> /mattpocock-skills:code-review   (when it matters)
  -> /ship   (or commit straight to a branch and merge yourself)
  -> /end-session   (LOG line only)
```

## Keeps
- `AGENTS.md` (short) and the one-line `CLAUDE.md`, `docs/LOG.md`, `docs/agents/workflow-settings.md`.
- Branches and PRs if the repo has CI; otherwise your call.

## Drops
- STATUS, HANDOFF, PLAN, phase files, `.scratch` specs and tickets (tickets can live as a checklist in the README).
- Explainers, day logs, vault notes, phase-end reviews.

## Move up to `full` when
- You lose track between sessions, or the project gets a second person or real users.
