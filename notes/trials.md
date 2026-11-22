# Trials

Changes to the toolbox being tried before they reach every project. One row per change. Beta copies live in `beta/` (full copies, mirroring the repo); production is everything else on `main`. How tracks work: `../DEVELOPING.md`, "Pace and release tracks".

When a trial ends, set the verdict: **keep** (move the beta copy over production, tag a release, add a `CHANGELOG.md` line), **tune** (change it and keep trying) or **drop** (move the beta copy to `archive/`, say why).

| Change | Should improve (success check) | Track | Trial project | Started | Rollback (if it creates or moves project files) | Notes | Verdict |
|---|---|---|---|---|---|---|---|
| **AGENTS.md as the main file** (decision 0006): instructions in `AGENTS.md`, `CLAUDE.md` only `@AGENTS.md`. Beta copies: `beta/templates/AGENTS.md`, `beta/templates/CLAUDE.md`, `beta/tools/Install-Workflow.ps1`, `beta/skills/setup-workflow/`, `beta/skills/refit-workflow/` | A second agent (Antigravity CLI) follows the same rules with no second instruction file, and Claude Code behaves as before; switching agents mid-work needs no re-explaining | beta | a personal GitHub project (switched by hand, guide: `notes/trials/agent-trial-template.md`); this repo | 2026-11-22 | `git rm CLAUDE.md`, `git mv AGENTS.md CLAUDE.md`, remove `workflow_track: beta`, delete local `.agents/` | First use of the beta track, built by hand: refit can't install `beta/` yet (ticket 17), and the global setup/refit stay production. Findings go in the project's `.scratch/<agent>-trial.md`, summary to `notes/research/`. | |
