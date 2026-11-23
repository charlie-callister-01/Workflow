# Matt Pocock v1.3.2 and main: what the toolbox must mirror

Type: research
Status: resolved
Blocked by: none

## Question

Since `setup-workflow` replaces `setup-matt-pocock-skills`, which changes in Matt Pocock's skills v1.3.2 and `main` (git remote before tracker, triage label creation, `CONTEXT.md` -> `GLOSSARY` rename, tracker template changes such as sub-issues and native blocking, fresh-context subagents, new skills like `retro`, `chief-of-staff`, `software-factory`) must the toolbox's templates and setup skills mirror, and which overlap with toolbox plans?

## Answer

- **The installed "1.3.1" is not the v1.3.1 tag:** the plugin cache sits between v1.3.1 (2026-10-04) and v1.3.2 (2026-10-29); `main` is 9 unreleased commits past v1.3.2. Diff against release tags, not the cache.
- **Mirror two v1.3.2 setup changes, adapted:** a git remote check before a GitHub tracker (`setup-workflow` step 1: `gh repo view` when the platform is `github`, so `/ship` can reach the repo); offer `git mv CONTEXT.md` (and `CONTEXT-MAP.md`) to the `GLOSSARY` names in `setup-workflow` and the `refit-workflow` analysis. `templates/docs/agents/domain.md` already uses `GLOSSARY`.
- **Tracker changes are GitHub Issues-only** (label creation, sub-issues, native `--blocked-by`, comment-then-close, own-repo guard); the local-markdown template is unchanged. Nothing now; if 35 or 06 allows GitHub Issues later, copy his v1.3.2 `issue-tracker-github.md`.
- **Subagents start with a fresh context, not a fork** (8 skills in v1.3.2; `main` adds a fresh `implement-spec` worker per ticket). Add one phrase to `refit-workflow` step 2 and the delegate line in `templates/AGENTS.md`.
- **`wayfinder` and `code-review` need nothing from us:** the toolbox already uses a `Type:` line and no labels; merging research notes into `notes/research/` is a deliberate divergence. `code-review` now reads `CODING_STANDARDS.md` / `CONTRIBUTING.md`.
- **New skills not urgent:** `retro` (in the plugin since v1.3.0); `chief-of-staff` and `software-factory` are in progress, not in the manifest (`chief-of-staff` runs `retro` on ~1 in 5 subagent sessions and keeps a dated wiki). Inputs to 15 and 09 (retro), 35 (wiki), 34 (chaining), 30.
- **`main` CI checks every `SKILL.md` frontmatter parses:** keep descriptions quoted (all nine are) and consider a frontmatter smoke check (30).

Note: [notes/research/2026-11-23 Matt Pocock v1.3.2 and main.md](../../../notes/research/2026-11-23%20Matt%20Pocock%20v1.3.2%20and%20main.md)
