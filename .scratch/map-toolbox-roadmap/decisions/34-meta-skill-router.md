# A meta-skill router

Type: grilling
Status: open
Blocked by: 13

## Question

Should the toolbox have its own meta-skill: a router that maps what the owner says (intent) and where the work is (lifecycle stage, change flow) to the skill that should run, and carries the standing discipline rules? Modelled on Addy Osmani's `using-agent-skills` (a router flowchart plus five non-negotiables: surface assumptions, stop and ask on conflicts, push back, prefer boring, touch only what's asked).

Points to decide:

1. **Is a router needed on Claude Code?** Addy deliberately does not wire his router on Claude Code or Codex, because they route skills natively by description and two routers conflict (research 01). Options: a full router skill, a SessionStart-injected one (30), a short intent -> skill table in `AGENTS.md`, or better skill descriptions only.
2. **Intent and lifecycle mapping:** the table itself: change flow (13) x stage (define, plan, build, verify, review, ship) -> skill, covering my skills and Matt Pocock's, and what happens when nothing matches.
3. **Entry points vs building blocks** (graduated from fog): which skills are user-only entry points (`disable-model-invocation: true`) and which the model may chain (see `ideas.md`, Skill chaining).
4. **Discipline rules:** do the five non-negotiables live in the router or in `AGENTS.md` (33)? Not both.
5. **Cost and portability:** how much context it adds per session, and whether other agents (Cursor, Codex, Antigravity) can use it (06).

Related: 01, 13, 26, 29, 30 (SessionStart injection), 33 (principles), 06 (multi-agent).
