# Ideas

Backlog of future plans and things to try. Move to `CHANGELOG.md` (and `decisions/` if needed) once adopted; strike through if dropped, with why.

## Direction
- [ ] **Find the best workflow for me**: research other ways of working and other people's workflows (findings in `research/`), try them as presets, keep what works. Everything here is a base to improve on.
- [ ] **Toolbox roadmap** (wayfinder map `.scratch/map-toolbox-roadmap/map.md`, destination `notes/roadmap.md`). First research: [Addy Osmani agent-skills](research/2026-11-22%20Addy%20Osmani%20agent-skills.md), [Cursor pstack and team kit](research/2026-11-22%20Cursor%20pstack%20and%20team%20kit.md), [ICM](research/2026-11-22%20Interpretable%20Context%20Methodology.md), [survey of skill sets](research/2026-11-22%20Survey%20of%20skill%20sets%20and%20workflows.md), [The Pragmatic Programmer](research/2026-11-22%20The%20Pragmatic%20Programmer.md), [Domain-Driven Design](research/2026-11-22%20Domain-Driven%20Design.md), [Model choice per agent](research/2026-11-22%20Model%20choice%20per%20agent.md), [What can be measured](research/2026-11-22%20What%20can%20be%20measured.md).
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
- [ ] **Package as a plugin**: so skills update in one place instead of being copied.

## Skills
- [ ] **Skill chaining**: how Matt Pocock's skills link together. The model can call any skill through the Skill tool unless it has `disable-model-invocation: true`; his user-only "entry" skills (wayfinder, grill-with-docs, to-spec, to-tickets, implement) compose model-callable "building blocks" (grilling, domain-modeling, research, prototype, tdd, code-review, pr). Ideas: let `/refit-workflow` run grilling + domain-modeling itself instead of handing over a line; decide which of my skills should be entry points vs building blocks.
- [ ] **Customise wayfinder starts**: per-project destinations and ticket types for the project-start map (decision 0005); keep or drop after the first try.
- [ ] **`-Force` re-sync** for `Install-Workflow.ps1`: refresh copied skills from the toolbox (needed where a repo carries copies, e.g. the Workflow repo itself).
- [ ] **Learning skill**: opt-in teaching mode (explain a change or concept at a chosen depth).
- [ ] **Weekly roll-up** for `day-log` (`Logs/YYYY-Wnn.md`).
