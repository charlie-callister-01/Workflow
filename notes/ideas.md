# Ideas

Backlog of future plans and things to try. Move to `CHANGELOG.md` (and `decisions/` if needed) once adopted; strike through if dropped, with why.

## Inbox
- 2026-11-25 · Workflow · A quick update-docs skill: refresh STATUS and HANDOFF (in `lite`, the LOG line) mid-session without running the whole `/end-session` (no branch sweep, no reminders, no commit offer beyond the docs). Ties to 39 (session bookends: what start and end read and write, skill scripts) and 15.
- 2026-11-25 · Workflow · An easier way to start new sessions, likely part of home's router: pick the project and the next step and launch a CLI session there in one go. Plus keeping track of the other CLI sessions running (which repo, branch or worktree, what each is on, which are idle or finished). Ties to 42 (home), 34 (router), 39 (session bookends, status page) and 36 (worktrees for parallel sessions).
- 2026-11-25 · Workflow · An inbox triaging skill: run what today's inbox triage grilling did by hand (each idea against the open tickets, a recommended destination and its effect on those tickets, owner confirms, notes written, Inbox cleared, one PR). Depends on 41 (how much routing is automatic, what still needs the owner) and 10 (the final directory structure ideas are filed into). Linked as an input on 41.

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

## For home
Ideas that belong to the home repo; this repo acts as home until roadmap ticket 42 is built, and this list is 42's starting checklist.
- [ ] **Machine inventory** (idea 2026-11-24 · Workflow): one place (a script plus its output) showing what is installed on each machine outside any repo: global skills (`~/.claude/skills`, `.agents/skills`, `[wf]` stamps and versions), agents and CLIs (`claude`, `gh`, `az`, `git`), runtimes and utilities (node, npm, python, dotnet) with their versions and install paths, per machine. Helps set up a new machine, spot drift between machines, and know what a sandbox (WSL2, dev container, cloud session) is missing. Machine-specific paths are private, so the output likely lives in home; the toolbox would hold only a generic script. Ties to the autonomous loops and sandboxes fog, 23 (updating) and 06 (per-agent setup lives in home).

## For knowledge
Ideas that belong to the knowledge repo (35); this list is its starting checklist (42), and most learning decisions are made in that repo once it exists.
- [ ] **ICM ideas for the learning space** (from roadmap ticket 40, 2026-11-26 · Workflow): take ICM's ideas, not its folder layout: context in layers (an entry file, a routing file, a short contract per topic or stage, references and working notes loaded only when listed), injecting only what a step needs, and a plain, reviewable output at each stage (e.g. sources, notes, summary, practice) before the next runs, so `tech-learning-coach` can work through a topic stage by stage. Untested: ICM's only education case is course-deck production, so trial it on one topic first, with the same kind of pass/fail test as 40's planning trial. Research: `notes/research/2026-11-26 ICM paper findings.md`.

## Skills
- [ ] **Skill chaining**: how Matt Pocock's skills link together. The model can call any skill through the Skill tool unless it has `disable-model-invocation: true`; his user-only "entry" skills (wayfinder, grill-with-docs, to-spec, to-tickets, implement) compose model-callable "building blocks" (grilling, domain-modeling, research, prototype, tdd, code-review, pr). Ideas: let `/refit-workflow` run grilling + domain-modeling itself instead of handing over a line; decide which of my skills should be entry points vs building blocks.
- [ ] **Customise wayfinder starts**: per-project destinations and ticket types for the project-start map (decision 0005); keep or drop after the first try.
- [ ] **`-Force` re-sync** for `Install-Workflow.ps1`: refresh copied skills from the toolbox (needed where a repo carries copies, e.g. the Workflow repo itself). Absorbed 2026-11-24: skills come from home's copy script (35); project files update through refit's update path and migrations (roadmap 23).
- [ ] **Learning skill**: opt-in teaching mode (explain a change or concept at a chosen depth).
- [ ] **Weekly roll-up** for `day-log` (`Logs/YYYY-Wnn.md`).
- [ ] **A strict review of written work** (idea 2026-11-25 · Workflow; build after roadmap 31 and 34): a new optional skill with thermo-nuclear's ambition, not focused on programming, for plans, specs, maps, decision tickets, `AGENTS.md`, skills, templates, docs and research: one source per rule, no duplication or contradiction, no bloat, every task has a check, one-way links, vague prose called out, restructuring moves. A light mode is the docs-only consistency pass (issue #16, 15). Complements the architecture review on plans (34): two fresh contexts, two angles. `thermo-nuclear-code-quality-review` stays as it is.
