# Preset: fast-lane

For: docs, config, and fixes under ~30 lines, inside a project that otherwise runs `full`. Also usable as the default for a mature project where most changes are small.

## Pipeline

```
/start-session -> branch (fix/ or chore/) -> change -> /open-pr -> /end-session
```

## Drops
- Grilling, spec and tickets.
- The explainer for docs-only PRs (`/open-pr` decides from `code_pattern`).

## Keeps
- Never commit to `main`; every change goes through a PR and CI.
- `/mattpocock-skills:code-review` still runs if any code changed.
- STATUS/HANDOFF/LOG still updated by `/end-session`.

## Move up to `full` when
- The change needs a decision you would want written down, or touches more than a couple of files of code.
