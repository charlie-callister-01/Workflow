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
- Pace: slow and tested. v2 changes reach projects as trials on the beta track (`beta/` overlay folder, `notes/trials.md`), then get promoted to production. Principles in `DEVELOPING.md`, "Pace and release tracks"; mechanics in decision ticket 17.
- Projects must never end up carrying files or skills they don't use: every v2 proposal says what lands in a project and why.
- Tracker: local markdown (`docs/agents/issue-tracker.md`, "Wayfinding operations"). Decision tickets are `decisions/NN-*.md` (never `issues/`, which holds work tickets from `/to-tickets`).

## Decisions so far

<!-- one line per resolved ticket: [title](decisions/NN-slug.md): gist -->

- [How model choice works per agent](decisions/18-model-choice-per-agent.md): Claude Code sets a subagent's model in its agent file, the spawn call or an env var (spawn wins), and `opusplan` plans on Opus and builds on Sonnet; Cursor, Codex and Gemini CLI each have per-subagent models with different precedence. A plan kept in repo files plus `AGENTS.md` is the neutral hand-off between vendors; `model:` values don't carry over.
- [What can be measured](decisions/20-what-can-be-measured.md): session transcripts (JSONL, kept 30 days) already hold per-call and per-subagent tokens, model and skill, so markers can be extracted automatically (e.g. at `/end-session`); the status line gets context % and plan % live; `/context` and `/usage` are on-screen only; OpenTelemetry has everything but needs a collector. Eight candidate trial markers listed for 21.

- [Addy Osmani's agent-skills](decisions/01-addy-osmani-agent-skills.md): 26 lifecycle skills plus personas and evals; strong on review, ship and production concerns where Pocock is strong on define and build. One portable `skills/` core with thin per-agent adapters (the pattern for 06). Borrow selected skills and the excuses / red-flags / verification sections; don't install the whole pack.
- [Cursor's pstack and cursor-team-kit](decisions/02-cursor-pstack-team-kit.md): team kit is 18 small stack-neutral skills (deslop, verify-this, CI loop); pstack is one person's heavy style (playbooks, one-rule principle skills, reflect/correct learning loop). Cursor loads `.claude/skills/` and `AGENTS.md`, so our skills likely work there already; keep agent-specific tool names out of skill bodies.
- [Survey of other skill sets and workflows](decisions/04-survey-other-methods.md): shortlist for deep dives: Matt Pocock v1.3.2/main (setup-workflow must mirror his setup fixes), obra/superpowers, Compound Engineering (lessons in `docs/solutions/`), GitHub Spec Kit (customisation layers), OpenSpec (specs archived into living specs). Runners-up: BMAD, GSD Core, anthropics/skills.
- [Books: The Pragmatic Programmer and Domain-Driven Design](decisions/12-books.md): Pocock's skills already carry most practical tips and DDD's ubiquitous language; gaps are one-liners (easier-to-change rule, broken windows to the refactor backlog, context relationships, translate external APIs at one seam, a core-domain line in PLAN.md). Learning topics feed 08; neither book needs a new skill.
- [Interpretable Context Methodology (ICM)](decisions/03-icm.md): folder-per-stage pipelines with a CONTEXT.md contract each; same principles as the toolbox but process lives in folders, not skills. Worth taking: per-task "load / don't load" tables, a no-placeholders check after setup, audit tables in file-writing skills, one-way links, line limits for `docs/agents/*.md`.
- [A fast ideas inbox](decisions/22-ideas-inbox.md): a global user-only `/idea` skill appends one dated line to the project's `docs/IDEAS.md` Inbox (created on first use); `/idea wf` sends toolbox ideas as GitHub `idea` issues (decision 0007); `/start-session` shows the count; `/idea` with no text triages each item into a decision ticket, ticket comment, map fog, backlog or drop. Everything after routing belongs to 09.
- [Addy Osmani: agent harness engineering](decisions/25-agent-harness-engineering.md): agent = model + harness; every `AGENTS.md` line should trace to a real failure (keep it near 60 lines), hooks enforce what prose can't (the toolbox has none: biggest gap), agree "how we'll check it" before coding. Durable state on disk and hand-offs are already the toolbox's strength.
- [Addy Osmani: the agent-skills blog post](decisions/26-agent-skills-post.md): skills are processes with a hard verification exit, not prose; scope discipline matters most. Agent configuration decays: prune by experiment (turn a skill off, keep it only if the agent then fails). Must-hold rules belong in hooks.
- [AI Hero: the home repo pattern](decisions/27-home-repo-pattern.md): one home repo, agent started there, plain pointers to other repos; shared skills live in one place so updates are just commits. Feeds 23: keep skills central (global or plugin), templates as per-project copies; borrow its setup inventory for refit.
- [Flavio Copes on pstack](decisions/28-pstack-flavio-copes.md): every task gets a goal plus a way to check it; loops need a finish condition and a decision log; review keeps dismissed findings with reasons. His fstack (nail, plan, build, check, push) backs `lite`; borrow "what we're NOT doing" and a three-question check before `/ship`.
- [The owner's notes on the three workflows](decisions/29-owner-notes-three-workflows.md): the common thread is moving rules from prose into hooks, checks and verification (the toolbox has none); hooks back the session skills rather than replace them; `/goal` over Ralph plugins, cloud sessions for unattended work; Mermaid state diagrams over TLA+; architecture tests per stack; Ship / Show / Ask fits 24.

## Not yet specified

- **Team preset** (`presets/team.md`) and **Azure team mode** (Boards mirror, work-item links, reviewers by path or risk). Probably shaped by the repo profile (07).
- **Distribution**: copies vs a plugin. Updating primed projects is now decision ticket 23.
- **Risk levels**: process that varies by the type and risk of a change (drafts in `platforms/*.md`).
- **Entry points vs building blocks**: which of my skills are user-only entry points and which the model may chain (see `ideas.md`, Skill chaining).
- **Deep dives** on the survey shortlist: superpowers (vs `/ship` and `/end-session`, transcript diagnosis), Compound Engineering (lessons that carry forward, post-PR care), Spec Kit (customisation layers, before the update flow), OpenSpec (what happens to `.scratch/` specs after merge). Ticket each when the question it feeds (05, 09, 10, distribution) needs it.
- **Roadmap phases**: the ordering of everything above into phases; graduates once 05-16 are resolved.

## Out of scope

- Making the changes the roadmap lists (normal `/ship` flow).
