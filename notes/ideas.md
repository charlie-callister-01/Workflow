# Ideas

Backlog of future plans and things to try. Move to `CHANGELOG.md` (and `decisions/` if needed) once adopted; strike through if dropped, with why.

## Inbox
- 2026-11-24 · Workflow · A machine inventory: one place (a script plus its output) showing what is installed on each machine outside any repo: global skills (`~/.claude/skills`, `.agents/skills`, `[wf]` stamps and versions), agents and CLIs (`claude`, `gh`, `az`, `git`), runtimes and utilities (node, npm, python, dotnet) with their versions and install paths, per machine. Helps set up a new machine, spot drift between machines, and know what a sandbox (WSL2, dev container, cloud session) is missing. Machine-specific paths are private, so the output likely lives in home; the toolbox would hold only a generic script. Ties to the autonomous loops and sandboxes fog, 23 (updating) and 06 (per-agent setup lives in home).
- 2026-11-24 · Workflow · `/idea` capture shouldn't interrupt the session's context: either a routed hook script (a prompt hook catches `idea ...`, appends the line, and stops the prompt before the model sees it) or a separate subagent that writes the line and returns only "noted". A hook is Claude-only, so under decision 0009 it is an optional extra over a plain script any agent can call; the subagent route is portable but still costs a little context. Feeds 22's `/idea` design (now in home's harness) and 30 (hooks).
- 2026-11-24 · Workflow · Rework the install scripts so they work with any agent, not just Claude Code. Needed: `Install-Workflow.ps1` still copies skills into the project's `.claude/skills/` and writes the `CLAUDE.md` shim, and `Install-GlobalSkills.ps1` installs only into `~/.claude/skills`. Decisions 06 and 35 already removed both (projects carry `AGENTS.md` only and no skills; home's copy script fills `.agents/skills` plus a `.claude/skills` junction) but nothing is built yet. Feeds 23 (updating) and the global-skills side of 17 (`<skill>-beta` installs).
- 2026-11-24 · Workflow · Rename the toolbox's `/ship` skill so it doesn't clash with Claude Code's built-in `/ship`: typing `/ship` ran the built-in (`ship-local`: always reviews, never commits). See issue #16; touches 15 and the copy script (36, work ticket 01).
- 2026-11-23 · Workflow · Levels of autonomy set by the type of project: how much the agent may do unattended depends on the kind of project (ties to the repo profile, 07, and the loops fog).

## Direction
- [ ] **Find the best workflow for me**: research other ways of working and other people's workflows (findings in `research/`), try them as presets, keep what works. Everything here is a base to improve on.
- [ ] **Toolbox roadmap** (wayfinder map `.scratch/map-toolbox-roadmap/map.md`, destination `notes/roadmap.md`). First research: [Addy Osmani agent-skills](research/2026-11-22%20Addy%20Osmani%20agent-skills.md), [Cursor pstack and team kit](research/2026-11-22%20Cursor%20pstack%20and%20team%20kit.md), [ICM](research/2026-11-22%20Interpretable%20Context%20Methodology.md), [survey of skill sets](research/2026-11-22%20Survey%20of%20skill%20sets%20and%20workflows.md), [The Pragmatic Programmer](research/2026-11-22%20The%20Pragmatic%20Programmer.md), [Domain-Driven Design](research/2026-11-22%20Domain-Driven%20Design.md), [Model choice per agent](research/2026-11-22%20Model%20choice%20per%20agent.md), [What can be measured](research/2026-11-22%20What%20can%20be%20measured.md), [Agent harness engineering](research/2026-11-23%20Agent%20harness%20engineering.md), [Addy Osmani agent-skills post](research/2026-11-23%20Addy%20Osmani%20agent-skills%20post.md), [Home repo pattern](research/2026-11-23%20Home%20repo%20pattern.md), [Flavio Copes on pstack](research/2026-11-23%20Flavio%20Copes%20on%20pstack.md), [Owner notes on the three workflows](research/2026-11-23%20Owner%20notes%20on%20the%20three%20workflows.md), [Loops, sandboxes and session hooks](research/2026-11-23%20Loops,%20sandboxes%20and%20session%20hooks.md), [Verification and enforceable architecture](research/2026-11-23%20Verification%20and%20enforceable%20architecture.md).
- [x] **A GLOSSARY.md for this repo's own terms**: done as `GLOSSARY.md` (2026-11-22).
- [ ] **Measure it**: tokens per session, PRs per week, time from spec to merge, to compare presets fairly.

## Platforms
- [ ] **Azure team mode**: an `azure` option that integrates heavily with Boards for team work: script the Boards mirror (`az boards`), link PRs to work items, required reviewers by path or risk, environment approvals.
- [ ] **GitHub personal mode**: a `github` option purely for personal projects: a `New-GhPr` wrapper like `New-AzurePr.ps1`, auto-merge docs-only PRs after CI.
- [ ] **Risk levels**: process that varies by the type and risk of a change (how much review, explainer, wait, approvals). Draft tables are in `platforms/*.md`.

## Presets and setup
- [ ] **Team preset**: fill in `presets/team.md` when a second person joins a project.
- [ ] **Shared-ticketing setups**: future setup variants that lean on shared ticketing (GitHub Issues, Azure Boards as the tracker) instead of local markdown.
- [ ] **My own Matt Pocock setup**: a skill that runs `setup-matt-pocock-skills` with my selections pre-chosen (issue tracker, labels, domain layout), offering e.g. GitHub Issues via his GitHub template. For now `setup-workflow` replaces it.
- [x] **Install script**: done as `tools/Install-Workflow.ps1` + `/setup-workflow` (2026-11-22).
- [ ] **Test `refit-workflow` on a real existing repo**: PoReader first, in its own session.
- [ ] **Update flow**: use `workflow_version` so `refit-workflow` can pull toolbox changes into primed repos.
- [ ] ~~**Package as a plugin**: so skills update in one place instead of being copied.~~ Dropped 2026-11-24: decision 0009 (no plugin; home copies skills in, agent-agnostic).

## Skills
- [ ] **Skill chaining**: how Matt Pocock's skills link together. The model can call any skill through the Skill tool unless it has `disable-model-invocation: true`; his user-only "entry" skills (wayfinder, grill-with-docs, to-spec, to-tickets, implement) compose model-callable "building blocks" (grilling, domain-modeling, research, prototype, tdd, code-review, pr). Ideas: let `/refit-workflow` run grilling + domain-modeling itself instead of handing over a line; decide which of my skills should be entry points vs building blocks.
- [ ] **Customise wayfinder starts**: per-project destinations and ticket types for the project-start map (decision 0005); keep or drop after the first try.
- [ ] **`-Force` re-sync** for `Install-Workflow.ps1`: refresh copied skills from the toolbox (needed where a repo carries copies, e.g. the Workflow repo itself).
- [ ] **Learning skill**: opt-in teaching mode (explain a change or concept at a chosen depth).
- [ ] **Weekly roll-up** for `day-log` (`Logs/YYYY-Wnn.md`).
