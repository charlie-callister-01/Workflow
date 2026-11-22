# <Project name>

<One paragraph: what it is, the stack, who works on it, any data rules (e.g. synthetic data only).>

## Start here
1. `/start-session`: fetches, checks the branch is current, reads `docs/STATUS.md` and the files listed in `docs/HANDOFF.md`. Do not re-derive state from git.
2. Need the plan? `docs/PLAN.md`. Terms? `GLOSSARY.md`. A phase? Only `docs/phases/P-NN.md`.
3. Workflow settings: `docs/agents/workflow-settings.md` (preset, platform, commands, paths).

## Solution map
- `<src/...>`: <what it holds>. <dependency rules>
- `<tests/...>`: mirror each src project.

## Commands (run from repo root)
- Build/test: `<test_command>` (warnings are errors?). Format: `<format_command>`; CI fails on drift?
- CI: `<pipeline file>` on <platform>; PRs into `main` must pass it.
- Open PRs only with `/ship`.

## Workflow (preset: <full | fast-lane | lite>, see the Workflow repo's presets/)
- Branch `feature/<name>`, `chore/` or `fix/` (`throwaway/` for test PRs); never commit to `main`. Commits: `type(scope): message (phase N)`.
- **Normal change:** `/mattpocock-skills:grill-with-docs` -> `/mattpocock-skills:to-spec` + `/mattpocock-skills:to-tickets` (`.scratch/pNN-<slug>/`) -> `/mattpocock-skills:implement` ticket by ticket -> `/mattpocock-skills:code-review` -> size check -> `/ship` -> `/end-session`.
- **Size check after review:** estimate the fix work (lines to read or change x ~12 tokens + ~20k). Over 160k: suggest a fix spec; over 200k: make it a fix spec.
- **Fast lane:** docs, config or fixes under ~30 lines skip grilling, spec and tickets: branch, change, `/ship`.
- **Phases are sliced as you go:** a short Specs list in `docs/phases/P-NN.md` (`next` / `planned` / `done` / `dropped`, plus `fix:` lines); only the `next` spec is detailed.
- **End of phase:** `/thermo-nuclear-code-quality-review` over the phase diff -> `docs/REFACTOR.md`; archive `.scratch/pNN-*`; branch sweep (`/end-session`).

## Context discipline
- Don't read whole large files or build output. Grep first, read ranges.
- Delegate wide searches/reviews to subagents; keep only conclusions in the main thread.
- Keep this file under ~120 lines; put detail in `docs/`.

## Agent skills
- Issue tracker: `docs/agents/issue-tracker.md`. Triage labels: `docs/agents/triage-labels.md`. Domain docs: `docs/agents/domain.md`. Platform: `docs/agents/platform.md`.
