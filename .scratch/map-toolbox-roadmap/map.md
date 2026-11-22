# Map: Toolbox roadmap

Label: wayfinder:map
Started: 2026-11-22

## Destination

`notes/roadmap.md` v1: a phased roadmap for evolving this Workflow repo, with Phase 1 sliced into concrete changes and the big questions decided (which outside methods to adopt, multi-agent projects, repo profiles and change flows, what happens after wayfinder and after implementation, the learning section, artifact organisation, the evolution loop, a status page). The toolbox is ongoing; this map ends at roadmap v1. The roadmap describes **v2**; v1 (tag `v1.0`, `notes/v1.md`) stays as it is apart from fixes.

## Notes

- Domain: this repo, Charlie's personal toolbox of skills, presets, platforms, templates and notes, used to set up new projects and bring existing ones in line. Evolve it; never start a second repo.
- Plan, don't do: tickets produce decisions. Changes happen afterwards through `feature/...` -> `/ship`.
- Override: research findings are kept, not thrown away. Each research ticket writes `notes/research/YYYY-MM-DD <topic>.md` (format in `notes/research/README.md`) on the map's branch; no `research/` branches.
- Claude Code is the main agent for now, but a project may use other agents (Cursor, Codex, Copilot), several at once.
- Grilling tickets: call the grilling and domain-modeling skills. Decisions with a real trade-off go to `notes/decisions/NNNN-*.md`.
- Open items in `notes/ideas.md` are absorbed here (tickets or fog); `ideas.md` stays the inbox for new ideas.
- Vocabulary is in `GLOSSARY.md` (decision ticket vs work ticket, repo profile vs change flow, ...). Grilling tickets add to it as terms settle.
- Projects must never end up carrying files or skills they don't use: every v2 proposal says what lands in a project and why.
- Tracker: local markdown (`docs/agents/issue-tracker.md`, "Wayfinding operations"). Decision tickets are `decisions/NN-*.md` (never `issues/`, which holds work tickets from `/to-tickets`).

## Decisions so far

<!-- one line per resolved ticket: [title](decisions/NN-slug.md): gist -->

- [Addy Osmani's agent-skills](decisions/01-addy-osmani-agent-skills.md): 26 lifecycle skills plus personas and evals; strong on review, ship and production concerns where Pocock is strong on define and build. One portable `skills/` core with thin per-agent adapters (the pattern for 06). Borrow selected skills and the excuses / red-flags / verification sections; don't install the whole pack.
- [Cursor's pstack and cursor-team-kit](decisions/02-cursor-pstack-team-kit.md): team kit is 18 small stack-neutral skills (deslop, verify-this, CI loop); pstack is one person's heavy style (playbooks, one-rule principle skills, reflect/correct learning loop). Cursor loads `.claude/skills/` and `AGENTS.md`, so our skills likely work there already; keep agent-specific tool names out of skill bodies.
- [Survey of other skill sets and workflows](decisions/04-survey-other-methods.md): shortlist for deep dives: Matt Pocock v1.3.2/main (setup-workflow must mirror his setup fixes), obra/superpowers, Compound Engineering (lessons in `docs/solutions/`), GitHub Spec Kit (customisation layers), OpenSpec (specs archived into living specs). Runners-up: BMAD, GSD Core, anthropics/skills.
- [Books: The Pragmatic Programmer and Domain-Driven Design](decisions/12-books.md): Pocock's skills already carry most practical tips and DDD's ubiquitous language; gaps are one-liners (easier-to-change rule, broken windows to the refactor backlog, context relationships, translate external APIs at one seam, a core-domain line in PLAN.md). Learning topics feed 08; neither book needs a new skill.
- [Interpretable Context Methodology (ICM)](decisions/03-icm.md): folder-per-stage pipelines with a CONTEXT.md contract each; same principles as the toolbox but process lives in folders, not skills. Worth taking: per-task "load / don't load" tables, a no-placeholders check after setup, audit tables in file-writing skills, one-way links, line limits for `docs/agents/*.md`.

## Not yet specified

- **Team preset** (`presets/team.md`) and **Azure team mode** (Boards mirror, work-item links, reviewers by path or risk). Probably shaped by the repo profile (07).
- **v1 and v2 side by side**: a "production" v1 and a "test" v2 of the toolbox, without clutter. A `v1` maintenance branch or a `v2/` folder, and how `/setup-workflow` and `/refit-workflow` choose which one a project gets. Depends on how big v2 turns out; decide with the roadmap phases.
- **Distribution and updates**: copies vs a plugin, `-Force` re-sync, how `workflow_version` lets `refit-workflow` pull toolbox changes into primed repos.
- **Measuring presets**: tokens per session, PRs per week, spec-to-merge time.
- **Risk levels**: process that varies by the type and risk of a change (drafts in `platforms/*.md`).
- **Entry points vs building blocks**: which of my skills are user-only entry points and which the model may chain (see `ideas.md`, Skill chaining).
- **Deep dives** on the survey shortlist: superpowers (vs `/ship` and `/end-session`, transcript diagnosis), Compound Engineering (lessons that carry forward, post-PR care), Spec Kit (customisation layers, before the update flow), OpenSpec (what happens to `.scratch/` specs after merge). Ticket each when the question it feeds (05, 09, 10, distribution) needs it.
- **Roadmap phases**: the ordering of everything above into phases; graduates once 05-16 are resolved.

## Out of scope

- Making the changes the roadmap lists (normal `/ship` flow).
