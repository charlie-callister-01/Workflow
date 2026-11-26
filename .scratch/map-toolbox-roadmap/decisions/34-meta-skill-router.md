# Flow table: which skill, which model, which planning method

Type: grilling
Style: doubt
Status: resolved
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

## From 15 (2026-11-26)

Docs-only PRs get a cheap consistency pass once the strict review of written work exists (its light mode); place it in the ship stage of docs-only work.

## Answer

Resolved 2026-11-26 (grilling, `doubt`: two rounds, then a fresh-context subagent tried to disprove the summary; seven objections taken, three in part). Built under the owner's staged, modular principle: configurable, observable, rolled out in stages, with a guide.

### Picks

| Source | Taken | Dismissed or parked |
|---|---|---|
| Osmani | His reason for no router on Claude Code and Codex: they route by skill description natively and two routers conflict. | The `using-agent-skills` router skill. |
| Pocock | Description routing; owner-only entry points; wayfinder for fog; fresh-context subagents. | - |
| pstack / fstack | Size picks the flow (fstack), confirming 13. | A separate principles index (overlaps `AGENTS.md`). |
| ICM | Load lists per stage as pointers; context in layers (40). | - |
| Research 18 | Name model tiers, not models; a plan in repo files is the neutral hand-off. | - |

### Decisions

1. **A table, not a router.** No router skill, no SessionStart injection. Routing is the agent-neutral flow table in `docs/agents/change-flows.md` plus sharp skill descriptions each agent routes on. **Layer 0** (home's `AGENTS.md` for personal repos, the shared-only block for shared repos) holds only 13's six-line flow and size table and one pointer to `change-flows.md`, so the agent can choose a flow before reading anything else.
2. **Table shape.** One short section per flow, a row per stage it uses (empty stages left out), columns **Stage | Skill | Tier | Who starts | Load**. Load holds **pointers only** (file names); which section and why stays in each skill's Inputs table (40), one home per fact. Under about 60 lines. Only the chosen flow's section is read, once the flow is confirmed.
3. **Docs-only work** is keyed on `code_pattern`, not a new flow: docs-only work in any flow gets the strict review of written work at review (once built) and its light mode as the consistency pass at ship (15).
4. **Model tiers.** `frontier` (define, plan, review), `standard` (build), `light` (research and exploring subagents that return a summary, and verify). Home's per-agent setup maps tiers to real models (06). A tier is **applied** to subagent spawns and to the model chosen at session start; for the main session's other stages it is advice. A frontier plan may be built by a lighter or other vendor's model when the plan is in repo files with `Check:` lines (31).
5. **Who starts.** Owner only: `start-session`, `end-session`, `setup-workflow`, `refit-workflow`, `day-log`, `vault-note`, `thermo-nuclear`, `/idea`, wayfinder. The model may chain: `open-pr`, grilling, tdd, `code-review`, `pr`, research, diagnosing-bugs, `pr-explainer`. A property of the toolbox's own skills (`disable-model-invocation` plus a plain "Only the owner starts this" line other agents read), tracked in the table's Who starts column and changed in the toolbox through a trial; not per project, since home serves one copy. Matt's skills, which the toolbox can't edit, get one line in `change-flows.md`. Name clashes with built-ins (`code-review`, `research`) go to the agent-neutral install scripts roadmap item.
6. **Planning method.** A signal table with a prompt override: decisions can't be listed yet -> wayfinder (13's wayfinder first); running something settles it -> prototype; the owner's own preferences -> interview; a `high_risk` match or the owner's prompt -> doubt; small and clear -> nail; otherwise rounds. The agent proposes the method in one line, as it proposes the flow.
7. **Research inside planning.** Inline: a fresh-context subagent limited to primary sources fetches what a question needs and returns a short summary. Matt's `research` skill only when the findings are worth a note (it always writes one).
8. **Reviews.** Architecture review (Pocock's `codebase-design` on a spec) at plan of start project and new feature as 31's `plan.review: design-review`, off by default, trialled. Strict review of written work at review of docs-only work (point 3). High-risk doubt review an extra review row when `high_risk` matches. Verify default: run the `Check:` line (31); `verify-this` parked.
9. **Per-project changes.** Only through Checks lines in 31's form: `<stage>.skill[.flow]` and `<stage>.tier[.flow]` (31's `review:` already picks the review skill). A project's `change-flows.md` copy is a plain template copy, not a second way to override. Defined and documented, none seeded; a project adds a line only when it needs one.
10. **Observable.** When a stage starts the agent says one line: `flow · stage · skill`, plus the tier where one was applied. The PR's `## Verification` section lists the flow and any changed cells (beside 31's and 15's lines).
11. **When nothing matches.** The agent says no skill fits and proposes chat work under the closest flow; the owner confirms. A recurring gap becomes an `/idea` line for 09's ratchet.
12. **Cost.** Skill descriptions stay about two lines each (they load every session); trimming joins the token-trimming roadmap item. Owner's idea: a `flow` script that prints the chosen flow's section with the project's Checks changes applied, also the observable resolved view; **not in stage 1** (it has no skill folder, and teammates in shared repos have no toolbox scripts), a stage 2 candidate in home's scripts (`sh` + `ps1`, 42), kept only if it saves tokens. Shared repos read the file.
13. **Modules and rollout.** Flow table (no dependency), method signals (none), who starts (frontmatter plus the plain line), tiers (home's per-agent setup, 42), per-project changes (31's Checks). Stage 1: flow table and method signals, used in this repo and on one code project for about a week, evaluated on how often the owner corrects the first proposed flow, skill or method, and tokens. Stage 2: tiers once home exists, plus the `flow` script candidate. Stage 3: per-project changes, only when a project needs one. One guide: **Flows and routing**.

### Dismissed

- Objection 8 in part: the Load column does not duplicate the skills' Inputs tables; 40 asked for both, and the column holds pointers only.

### Handed on

- **09**: stage 1's evaluation (corrections of the first proposal, how counted) and recurring "no skill fits" gaps.
- **10**: where the Flows and routing guide lives.
- **37**: `change-flows.md` is a template copy; no routing lines seeded; the six-line table in the shared-only block.
- **39**: `/start-session` reads layer 0 only (the six-line table), not `change-flows.md`; any LOG-line marker for corrections.
- **Roadmap items**: name clashes in the install scripts item; skill description trimming in the token-trimming item; the `flow` script candidate in home.

Decision 0016.
