# Map: Toolbox roadmap

Label: wayfinder:map
Started: 2026-11-22

## Destination

`notes/roadmap.md` v1: a phased roadmap for evolving this Workflow repo, with Phase 1 sliced into concrete changes and the big questions decided (which outside methods to adopt, multi-agent projects, the configuration model, the learning section, artifact organisation, the evolution loop). The toolbox is ongoing; this map ends at roadmap v1.

## Notes

- Domain: this repo, Charlie's personal toolbox of skills, presets, platforms, templates and notes, used to set up new projects and bring existing ones in line. Evolve it; never start a second repo.
- Plan, don't do: tickets produce decisions. Changes happen afterwards through `feature/...` -> `/ship`.
- Override: research findings are kept, not thrown away. Each research ticket writes `notes/research/YYYY-MM-DD <topic>.md` (format in `notes/research/README.md`) on the map's branch; no `research/` branches.
- Claude Code is the main agent for now, but a project may use other agents (Cursor, Codex, Copilot), several at once.
- Grilling tickets: call the grilling and domain-modeling skills. Decisions with a real trade-off go to `notes/decisions/NNNN-*.md`.
- Open items in `notes/ideas.md` are absorbed here (tickets or fog); `ideas.md` stays the inbox for new ideas.
- Tracker: local markdown (`docs/agents/issue-tracker.md`, "Wayfinding operations"). Tickets are `issues/NN-*.md`.

## Decisions so far

<!-- one line per resolved ticket: [title](issues/NN-slug.md): gist -->

## Not yet specified

- **Team preset** (`presets/team.md`) and **Azure team mode** (Boards mirror, work-item links, reviewers by path or risk). Probably shaped by the configuration model (07).
- **Distribution and updates**: copies vs a plugin, `-Force` re-sync, how `workflow_version` lets `refit-workflow` pull toolbox changes into primed repos.
- **Measuring presets**: tokens per session, PRs per week, spec-to-merge time.
- **Risk levels**: process that varies by the type and risk of a change (drafts in `platforms/*.md`).
- **Entry points vs building blocks**: which of my skills are user-only entry points and which the model may chain (see `ideas.md`, Skill chaining).
- **Deep dives** on whatever the survey (04) shortlists.
- **Roadmap phases**: the ordering of everything above into phases; graduates once 05-10 are resolved.

## Out of scope

- Making the changes the roadmap lists (normal `/ship` flow).
