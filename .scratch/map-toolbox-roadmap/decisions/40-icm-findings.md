# The owner's ICM research and what to take from it

Type: grilling
Style: interview
Status: resolved
Blocked by: none

## Question

The owner has been researching Interpretable Context Methodology (ICM) personally, beyond research ticket 03. This session (38 merged in) brings that research in and grills the owner on it: what they found, what the toolbox should take from it, and what to leave. Open with the owner's own findings and sources, not the agent's summary of 03; where a fact needs checking, send a research subagent limited to ICM's primary sources and write `notes/research/YYYY-MM-DD <topic>.md` if the findings are worth keeping. The picks panel (map Notes) has ICM as its only source, with 03's points as prompts. Decide:

1. **The ICM takeaways line** in the map's Notes, replacing "pending 40".
2. **What it means for open tickets:** artifact organisation (10: folder per stage, `CONTEXT.md` contracts, where things live), the load / don't-load table per stage marked in 34 (flow table), and what a session loads at start marked in 39 (session bookends). If 34 or 39 has already resolved, add a "From 40" note to it as an input for the roadmap.
3. **Anything that reshapes the map:** a new ticket, a change to 10's or 14's question, or a roadmap item.

Created 2026-11-24 at the owner's request, then merged with 38 (the owner's own ICM research): the owner runs it next, in a fresh session after PR #24 ships. Related: 03 (ICM research), 05 (what was borrowed from 03), 10, 34, 39.

## Answer

Resolved 2026-11-26 (interview). The owner read the ICM paper (Van Clief and McDermott, arXiv:2603.16021v2); quotes checked against the paper, the repo README and `_core/CONVENTIONS.md` in [notes/research/2026-11-26 ICM paper findings.md](../../../notes/research/2026-11-26%20ICM%20paper%20findings.md).

1. **Takeaways line** (map Notes): context in layers, injected per stage; every stage leaves a plain, reviewable file; stage folders with `CONTEXT.md` contracts for planning artifacts only, on trial; one-way links, one canonical home per fact, audit tables before saving.
2. **Direction for dev work:** planning artifacts (grill, spec, tickets) move toward ICM-style stage folders, each with a `CONTEXT.md` contract (load / don't load, outputs, checkpoint) and a human review at each boundary; code is untouched. The aim: plan refactors stay organised, trackable and consistent. 40 sets the direction only; **10 designs the layout and runs it as a beta trial** (17) on one real feature.
3. **The trial's test** (agile change): **pass** when a requirement that moves after the spec is handled by editing the earliest affected stage output and re-running only downstream stages, nothing upstream rewritten by hand; each stage output is committed so the change is traceable in git (ICM has "observability but not traceability"); the agent loads only what each contract lists (checked with 20's markers). **Fail** when contracts go stale and are edited more than the plan, the load table is ignored, or the ceremony costs more than it saves on a small change. Review-by one week (17).
4. **Context layers in the toolbox** (notes on 34 and 39): 0 `AGENTS.md` (always); 1 `workflow-settings.md`, LOG tail or STATUS, the active map (at start); 2 the skill for the stage, or a stage `CONTEXT.md` in a trial folder; 3 `docs/agents/*.md`, `GLOSSARY.md`, decisions (only when listed); 4 specs, tickets, code (only those named). In the toolbox the skill is the stage contract, so load tables live in skills and the flow table, not in a `CONTEXT.md` everywhere.
5. **Learning:** what carries over is ICM's **ideas** (layers, injection, reviewable stage outputs), not its folder layout; the paper's only education case is course-deck production, so this is the owner's extension and untested. Shelved for the knowledge repo: a new `## For knowledge` list in `notes/ideas.md` (as `## For home`) holds the decisions ready to build from; most deciding and building happens in the knowledge repo itself.
6. **Map:** no new tickets. 10's question gains the planning stage-folder trial; notes on 10, 14, 31, 34, 39 and 42; the leftover-placeholder check becomes a roadmap item.

No ADR: a direction plus a trial, no trade-off settled yet.

## Picks

| Source | What it does about this question | Owner's call |
|---|---|---|
| ICM | Five context layers read top-down, stop when enough; Inputs table with section scope per stage | **pick**: layer table for 34 and 39 |
| ICM | Stage folders with `CONTEXT.md` contracts; every output a plain file reviewed at each boundary | **pick** for planning artifacts, as 10's beta trial; **reject** for code |
| ICM | Observability through files ("no logging layer to build") | **pick**; git commits per stage give the trace ICM lacks |
| ICM | Leftover-placeholder scan after setup | **pick**: roadmap item |
| ICM | Audit tables (check, pass condition) before saving | **pick**: into 31's Verification checklists, not a second format |
| ICM | One-way links, canonical-source grep test, docs over outputs | **pick**: conventions for 10 |
| ICM | Line caps for `docs/agents/*.md` | **park**: Osmani's ~60-line `AGENTS.md` covers the main file; 09's prune-by-experiment can add caps if a file bloats |
| ICM | Applied to learning (owner's own extension) | **pick** the ideas, **park** the build: `## For knowledge` |

Taken from ICM: layered, injected context and observable stage outputs; the planning stage-folder trial; small conventions. Left: stage folders for code, line caps for now.
