# Changelog

One line per change to the workflow, newest first: what changed and why. Bigger choices get a note in `notes/decisions/`.

## 2026-11-22
- `setup-workflow` prints the exact command to install the Matt Pocock skills plugin when it is missing, and `SETUP.md` gives the same command. Why: pointing at SETUP.md left the owner hunting for the marketplace.
- Wayfinder for foggy project starts (exploring): `full` preset gains a "Project start" stage, `setup-workflow` offers the wayfinder line, `start-session` shows a map's frontier, `research/` branches are swept. Why: don't spec on guesses when the way to a plan is unclear. Decision 0005.
- Added `setup-workflow` and `refit-workflow` (global skills), `tools/Install-Workflow.ps1` (copies without overwriting) and `tools/Install-GlobalSkills.ps1`; `workflow_version` in settings. Why: prime a repo in one command, and merge into or update an existing workflow without bloat. `setup-workflow` replaces `setup-matt-pocock-skills` for primed repos.
- Added `.gitattributes` (LF for text, CRLF for PowerShell).
- First version: extracted from the PoReader project's workflow. Skills made generic (they read `docs/agents/workflow-settings.md`), presets `full` / `fast-lane` / `lite` (+ `team` later), platforms `github` / `azure`, templates, and a `notes/` folder for developing the workflow. Why: reuse the workflow across projects and improve it in one place.
