# Workflow

Charlie's toolbox for a software development and AI workflow: Claude Code skills, project templates, presets, platforms, and notes on developing the workflow. Markdown plus a few PowerShell 5.1 scripts; no app code. Personal repo on GitHub: never add employer, customer or personal details.

## Start here
1. `/start-session`: fetches, checks the branch is current, reads the README and the last 5 commits (preset `lite`).
2. What the toolbox is: `README.md`. How to use it: `SETUP.md`. Settings and knobs: `CUSTOMISING.md`. Future plans: `notes/ideas.md`.
3. Workflow settings: `docs/agents/workflow-settings.md` (preset `lite`, platform `github`).

## Repo map
- `skills/`: the toolbox's skills (core, optional, global). **Edit here, never in `.claude/skills/`.**
- `.claude/skills/`: copies of the core skills so this repo uses its own workflow. After changing a core skill, delete its copy and re-run `powershell -File tools/Install-Workflow.ps1 -Project . -Preset lite -Platform github -Skills core`.
- `templates/`, `presets/`, `platforms/`, `tools/`: what `/setup-workflow` copies into projects.
- `notes/`: research, ideas, decisions for developing the workflow. `CHANGELOG.md`: one line per change.

## Commands
- No build or tests. Smoke test for the install script: `-DryRun` into an empty temp folder (see `workflow-settings.md`).
- After changing `skills/setup-workflow` or `skills/refit-workflow`: `powershell -File tools/Install-GlobalSkills.ps1`.
- PowerShell 5.1: read and write text as UTF-8 explicitly; scripts must run on 5.1 (no `&&`, `??`, ternaries).

## Workflow (preset: lite, see presets/lite.md)
- Branch `feature/<name>`, `chore/` or `fix/`; never commit to `main`. Commits: `type(scope): message`.
- Change -> `/ship` (PR via `gh`) -> Charlie merges: squash for notes/docs, merge commit for `skills/`, `tools/`, `templates/`.
- Every change to the toolbox gets a `CHANGELOG.md` line; a real trade-off also gets `notes/decisions/NNNN-*.md`.
- `/end-session`: one line in `docs/LOG.md`.

## Agent skills
- Issue tracker: `docs/agents/issue-tracker.md`. Triage labels: `docs/agents/triage-labels.md`. Domain docs: `docs/agents/domain.md`. Platform: `docs/agents/platform.md`.
