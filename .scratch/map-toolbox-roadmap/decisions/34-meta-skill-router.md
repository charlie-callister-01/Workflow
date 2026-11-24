# A meta-skill router

Type: grilling
Status: open
Blocked by: 13, 36

## Question

Should the toolbox have its own meta-skill: a router that maps what the owner says (intent) and where the work is (lifecycle stage, change flow) to the skill that should run, and carries the standing discipline rules? Modelled on Addy Osmani's `using-agent-skills` (a router flowchart plus five non-negotiables: surface assumptions, stop and ask on conflicts, push back, prefer boring, touch only what's asked).

Points to decide:

1. **Is a router needed on Claude Code?** Addy deliberately does not wire his router on Claude Code or Codex, because they route skills natively by description and two routers conflict (research 01). Options: a full router skill, a SessionStart-injected one (30), a short intent -> skill table in `AGENTS.md`, or better skill descriptions only.
2. **Intent and lifecycle mapping:** the table itself: change flow (13) x stage (define, plan, build, verify, review, ship) -> skill, covering my skills and Matt Pocock's, and what happens when nothing matches.
3. **Entry points vs building blocks** (graduated from fog): which skills are user-only entry points (`disable-model-invocation: true`) and which the model may chain (see `ideas.md`, Skill chaining).
4. **Discipline rules:** do the five non-negotiables live in the router or in `AGENTS.md` (decided in 05, which absorbed 33)? Not both.
5. **Cost and portability:** how much context it adds per session, and whether other agents (Cursor, Codex, Antigravity) can use it (06).

Related: 01, 13, 26, 29, 30 (SessionStart injection), 05 (principles, with 33 merged in), 06 (multi-agent).

## From 05 (2026-11-23)

Point 4 decided: the Working rules live in `AGENTS.md`, not in a router. The router may surface the plan's Scope block. Borrowed skills come in one trial at a time; Pocock's skills and built-ins stay the defaults.

## From 35 (2026-11-24)

Sessions start in home, so any intent -> skill table belongs in home's `AGENTS.md` (agent-neutral), not in each project; a router skill would be one of home's copies. Point 5's portability weighs more now that the workflow is agent-agnostic.

## From 36 (2026-11-24)

Session skills name the session project in their first line and read its `AGENTS.md` explicitly (36); a router in home's `AGENTS.md` routes to skills, not to repos.
