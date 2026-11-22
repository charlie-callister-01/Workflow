# Changelog

One line per change to the workflow, newest first: what changed and why. Bigger choices get a note in `notes/decisions/`.

## 2026-11-22
- Added `.gitignore` for `.vs/`. Why: Visual Studio cache showed up as untracked.
- This repo's `code_pattern` also matches `beta/skills|tools|templates/`. Why: `/ship` classed beta changes as docs-only and would pick squash.
- **Beta:** `AGENTS.md` as the project's instruction file, with `CLAUDE.md` only `@AGENTS.md` (beta copies of the templates, `Install-Workflow.ps1`, `setup-workflow` and `refit-workflow` in `beta/`; production unchanged). This repo switched too. First trial on the beta track, with Antigravity CLI; guide in `notes/trials/agent-trial-template.md`. Why: one instruction file for every agent, to trial a second agent beside Claude. Decision 0006.
- `SETUP.md` step 0: clone this repo and pull before every setup or refit; `USING.md`: tag LOG lines with the agent when using more than one. Why: setup never said where the files come from.
- v2 planning: agreed pace and release tracks (production on `main`, beta as a `beta/` overlay folder of full copies, `notes/trials.md` as the trials board, rules for switching a project mid-way), written into `DEVELOPING.md`; glossary terms Track and Trial; mechanics in roadmap decision ticket 17. Why: develop slowly and tested, see what's on trial, and never overwhelm a project.
- v2 planning: added `GLOSSARY.md` for the toolbox's own terms and `notes/v1.md` (tag `v1.0`); README status split into v1 (in use) and v2 (in planning). Why: v1 must stay stable and understood while v2 is planned.
- README rewritten as a front door with a "Where I'm up to" section; new `USING.md` (working in a primed project) and `DEVELOPING.md` (the improvement loop, where notes go, making and releasing a change). Why: the repo had no readable path for "what now" in either role.
- Every toolbox skill's description starts `[wf]` so it stands out in the `/` menu. Why: tell my skills apart from Matt Pocock's and built-ins at a glance.
- Wayfinder maps live in `.scratch/map-<effort>/` with **decision tickets** in `decisions/`, apart from a spec's **work tickets** in `issues/` (tracker template, `start-session`). Why: the two kinds of ticket were easy to mix up.
- `setup-workflow` prints the exact command to install the Matt Pocock skills plugin when it is missing, and `SETUP.md` gives the same command. Why: pointing at SETUP.md left the owner hunting for the marketplace.
- Wayfinder for foggy project starts (exploring): `full` preset gains a "Project start" stage, `setup-workflow` offers the wayfinder line, `start-session` shows a map's frontier, `research/` branches are swept. Why: don't spec on guesses when the way to a plan is unclear. Decision 0005.
- Added `setup-workflow` and `refit-workflow` (global skills), `tools/Install-Workflow.ps1` (copies without overwriting) and `tools/Install-GlobalSkills.ps1`; `workflow_version` in settings. Why: prime a repo in one command, and merge into or update an existing workflow without bloat. `setup-workflow` replaces `setup-matt-pocock-skills` for primed repos.
- Added `.gitattributes` (LF for text, CRLF for PowerShell).
- First version: extracted from the PoReader project's workflow. Skills made generic (they read `docs/agents/workflow-settings.md`), presets `full` / `fast-lane` / `lite` (+ `team` later), platforms `github` / `azure`, templates, and a `notes/` folder for developing the workflow. Why: reuse the workflow across projects and improve it in one place.
