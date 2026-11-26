# Flow table: which skill, which model, which planning method

Type: grilling
Style: doubt
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

## From 30 (2026-11-24)

Input, not decided: **portable agent hooks** (one script, plus a per-agent trigger file home's copy script writes for each agent that has hooks) would live in home and run for every session started there. Whether the router starts or lists them is a question here. 30 builds none now and says an agent hook only starts an existing script.

## Map refit (2026-11-24)

Session E: one table, change flow x stage -> skill **and model**. Takes in **19** (read its question and notes): which model each step and each subagent uses, set agent-neutrally. Take after 31, whose answer may pick the verify-stage default (`verify-this`); mark it "31's default" if 31 isn't resolved. Two new points:

6. **Choosing a planning method:** how a question gets its method: a wayfinder map, a prototype, or a grilling style (`rounds`, `nail`, `interview`, `doubt`; map Notes). Options: a fixed table by signals (hard to reverse? fuzzy? small?), the meta-skill, or the prompt saying so. Owner's lean: a fixed table with a prompt override.
7. **Research inside planning in projects:** whether project sessions send research subagents during grilling, as this map's sessions do.

**From 40 (2026-11-26), load tables:** each flow table row (flow x stage -> skill) gets a **Load / Don't load** column, and each skill a short Inputs table (source, section, why; section scope, not whole files). In the toolbox the skill is the stage contract (ICM layer 2), so the tables live in skills and the flow table, not in a `CONTEXT.md` everywhere. Portable agent hooks are no longer a question here: they arrive only through 09's ratchet.

## From the inbox (2026-11-25)

Two complementary review skills to place in the flow table, each its own fresh context and angle (the owner's principle: complementary reviewers, plus doubt-driven design; map Main takeaways):

- **Architecture review on plans:** Pocock's `codebase-design` (was `improve-codebase-architecture`, used in `.scratch/architecture-deepening/`) applied to a spec, map or roadmap before code exists: deep modules and seams in the design being planned. Candidate for the plan stage of start project and new feature; trialled (17) once placed.
- **A strict review of written work** (to build; backlog in `notes/ideas.md`, Skills): thermo-nuclear's ambition applied to plans, specs, maps, decision tickets, `AGENTS.md`, skills, templates, docs and research: one source per rule, no duplication or contradiction, no bloat, every task has a check, one-way links, vague prose called out, restructuring moves. Candidate for the review stage of docs-only and planning work. `thermo-nuclear-code-quality-review` stays as it is for code.

## From 31 (2026-11-26)

Place two fresh-context reviews that 31 defines as settings: `plan.review` (`design-review` or `doubt` on a spec before tickets; off until a skill for that kind is promoted) and the doubt review a `high_risk` change gets. 31 also puts one line in `docs/agents/change-flows.md`: a ticket that adds or changes a status field gets a Mermaid state diagram and a transition-table test.
