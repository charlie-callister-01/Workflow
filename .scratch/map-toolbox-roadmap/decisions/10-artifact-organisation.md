# Artifact organisation and export

Type: grilling
Style: interview
Status: resolved
Blocked by: 35, 40

## Question

How are the artifacts a project produces (research, changes, lessons learned, decisions) organised in the repo so they are readable and searchable; how is research captured, summarised (summary or index) and passed on to ideas, decisions and the vault; and which are exported to outside places such as the Obsidian vault, and how?

## Merged in: 08, learning section (2026-11-23)

Where coding practices, learning notes and book notes (see 12) live, what shape they take, and how something learned becomes a skill, rule or template change. Read with 35's answer on whether this repo becomes an LLM-kept wiki (`notes/index.md`, ingest / query / lint, research 29) and its relation to the Obsidian vault.

## From 35 (2026-11-24)

The Obsidian vault is replaced by a private **knowledge repo** (learning is a folder in it); it is the LLM-kept wiki. This repo's `notes/` stays the toolbox's own record. Organise and export both here; ideas reach the knowledge repo from the home repo.

## From 35, review (2026-11-24)

Review: now three places, not one repo plus a vault: each project's artifacts, the toolbox's `notes/`, and the knowledge repo. The directory map fog spans all three.

## Map refit (2026-11-24)

Session G, opened with what 40 took from the owner's ICM research. Takes in from 09: how `ideas.md` / the inbox, the roadmap, `CHANGELOG.md` and the decision records relate. The directory map page is no longer a fog patch: once this resolves, writing it is a roadmap item.

## From 40 (2026-11-26)

New point for this session: **design the planning stage-folder layout** (grill, spec, tickets for one effort, each stage with a `CONTEXT.md` contract: load / don't load, outputs, checkpoint; a human review at each boundary; code untouched) and run it as a beta trial (17) on one real feature, with 40's pass/fail test (edit the earliest affected stage, re-run only downstream, each stage output committed; fail if contracts go stale, the load table is ignored, or the ceremony outweighs a small change). Conventions to adopt: one-way links, one canonical home per fact (grep test), docs over outputs. Learning (from 08) moves out: the knowledge repo decides its own layout from `## For knowledge` in `notes/ideas.md`; this ticket keeps only what the toolbox and projects export to it.

## Owner principle (2026-11-26)

The owner's new standing principle (map Main takeaways): every module ships with a **guide** (what, why, how to use, how to configure, how to tell it is working). Decide where guides live in the toolbox and how they are indexed (possibly the planned directory map page), and whether they also serve as the learning material 08 merged in here.

## From 15 (2026-11-26)

15 adds one guide, **Shipping** (five modules: session-branch, docs fast path, ci-watch, sync-main, cross-repo PRs). Decide where it lives with the other module guides.

## From 34 (2026-11-26)

34 adds the **Flows and routing** guide (flow table, method signals, who starts, tiers, per-project changes). Decide where it lives with the other module guides.

## From the inbox (2026-11-27)

A hard naming framework for plan breakdowns per project (from GitHub issue #37): phases, slices, sections and refits have drifted into different names ("phase 3 slice a section 5"), so each project needs one fixed hierarchy and wording, with its terms in the glossary. Ties to ICM's stage folders (40).

## From 39 (2026-11-27)

A new artifact: the **session note**, one per session branch, about 15 lines, deleted when the work is done. Its exact location (provisionally `.scratch/sessions/<branch>.md`) is settled in the map's Directory and design fog, with the rest of the layout.

## From 09 (2026-11-27)

New artifacts to place and relate: a trial file per trial (`notes/trials/<slug>.md`, with `notes/trials.md` as its index), and in home a per-machine markers file (`markers/<machine>.csv`) and a weekly review file (`reviews/YYYY-Www.md`) holding `retro` proposals with accepted / rejected / backlog calls. On keep, a trial's lessons go into the module's guide (where guides live is this ticket's). Accepted proposals leave as `/idea` lines.

## Answer

Resolved 2026-11-27 (grilling, `interview`: ten questions, one at a time; a research subagent checked the plan-level names against Jira, Azure DevOps, Linear, GitHub, Shape Up, SAFe, the Scrum Guide and Pocock). Decision 0020.

### Picks

| Source | Taken | Dismissed or parked |
|---|---|---|
| Pocock | Dated, source-cited claims (`chief-of-staff`'s wiki) for anything exported to the knowledge repo; "vertical slice" as the meaning of Slice. | - |
| Osmani | Docs say why, not what; docs are references other files point to. | - |
| pstack / fstack | - | `what-did-i-get-done` / `weekly-review` status from commits: parked, 39's status page and the LOG cover it. |
| ICM | One canonical home per fact (the grep test), one-way links, docs over outputs, `CONTEXT.md` as routing under 80 lines, stage contracts in the planning folders. | - |

### Decisions

1. **Boundary.** This ticket decides which artifacts exist, the one job of each, which is canonical for what, how they link and how content flows; **Directory and design** decides every path and folder name. Names below are provisional.
2. **One home per fact.** Idea inbox / backlog: ideas not yet routed, one line, leaves once routed. Decision ticket: the full answer to one planning question. ADR: why this over that, and when to reverse, only for real trade-offs. Map Decisions so far: an index, one gist line plus link. `CHANGELOG.md`: what changed in the toolbox and when, **one or two lines plus a link**, never restating the answer. `docs/LOG.md`: what a session did and what is next, **one or two lines plus links** to PRs and tickets. Trial file: a trial's evidence and verdict (09). Research note: facts from sources. `GLOSSARY.md`: what a word means. Projects use the same table minus the toolbox-only rows.
3. **Research.** Each note opens with the question and a **Summary** of at most 5 lines (answer first), then dated sources, findings and "might change". The index is generated by a script on demand, never committed. No "used by" back-links (one-way rule): tickets point at research, grep finds the users. Projects use the same format.
4. **Guides.** One guide per module group, in the toolbox only, with five headings (what it is, why, how to use it, how to configure it, how to tell it's working). `USING.md` becomes the front door (a one-line-per-guide table); `CUSTOMISING.md` becomes a pointer list from every setting to its guide. Projects carry no guides; their Checks lines and settings name the guide by its toolbox path. Guides are the learning material for the workflow itself: the knowledge repo links to them, never copies. `notes/workflow-guide.md` is folded into the guides and retired.
5. **Export to the knowledge repo.** Exported: research findings that are general rather than project-specific, and things the owner learned. Never exported: decisions, ADRs, specs, tickets, LOG lines, trial files. A one-liner goes by `/idea`'s knowledge route; a whole note is copied into the knowledge repo's drop folder (42) with a header naming the source repo, path, commit and date. The research step asks once, "general enough for knowledge?", and copies on a yes. The knowledge repo files what arrives on its own terms.
6. **Planning folders** (40's stage folders): `.scratch/<spec>/` holds a routing `CONTEXT.md` (stages, which is current, what is stale; under 80 lines) and three numbered planning folders, `01-grill` (`decisions.md`), `02-spec` (`spec.md`) and `03-tickets` (`NN-<slug>.md`), each with a `CONTEXT.md` stage contract: Inputs (file, section, why), Process (names the skill: `grill-with-docs`, `to-spec`, `to-tickets`; never restates it), Outputs, Checkpoint. The owner reviews each output before the next runs, and each is committed on its own. A change edits the earliest folder affected; the routing file marks later ones stale and they are re-run, never hand-patched. Wayfinder maps keep their own shape.
7. **The trial.** Planning folders only where 34's flow table already writes a spec; small changes and fixes never get them. Run on the next real spec-sized feature, in a project the owner picks, on the template beta track (templates in `beta/`), reviewed **at the end of that feature**. Pass condition (09's format): a requirement moved after the spec is handled by editing the earliest folder affected and re-running only later ones; each output committed; peak context and tokens per stage no worse than the last feature planned the old way. Drop if contracts go stale, the agent ignores the Inputs table, or tokens rise more than 20% for nothing. If no requirement moves on its own, one decision is changed after the spec on purpose.
8. **Plan levels** (issue #37's naming drift), the same in every project, in `GLOSSARY.md`: **Roadmap** > **Phase** (`P1`) > **Slice** (`P1-a`, thin and end-to-end, always named) > **Map** or **Spec** > **Planning folder** (specs only) > **Ticket** (decision or work). Refer by name first, number inside the name: "P1-a Session facts". Not used in plans: section, part, step. "Refit" means only `/refit-workflow`; reshaping a map is a **map rework**. Research changed the draft: "Effort" dropped as a level (an estimate field in Azure DevOps, and vague), "Stage folder" renamed Planning folder (Stage is a change-flow step), Phase kept over Milestone (a GitHub due-date marker) with a note that phases are not waterfall gates, and Slice defined as end-to-end (the industry's vertical slice).
9. **Keeping it.** The one-home table lives in the guide and the levels in the glossary; `/end-session` writes the short CHANGELOG and LOG lines, fixing the main duplication where it is written; the strict review of written work (ideas backlog), light mode, checks one home per fact and the unused words. A grep script for duplicated phrases or those words comes only if 09's weekly review records drift (30).
10. **Rollout.** Now, no trial (conventions): the one-home table with short CHANGELOG and LOG lines from this session on, research summary first, the plan levels in the glossary; the research index script ships with 09's stage 1 tooling. Then the **guides module** (folder, five-heading template, `USING.md` front door, `CUSTOMISING.md` settings list, `notes/workflow-guide.md` folded in), each later module bringing its own guide. Then the **planning-folder trial** (`plan.stage_folders`: off, on for the trial project). Then **knowledge export** after 42's stage A (`research.ask_knowledge`). Trace: commits per planning folder, the source stamp on each export. Evaluation: the trial per point 7; short lines judged at 09's weekly review by tokens per `/end-session`.

Glossary: Plan levels (Roadmap, Phase, Slice, Planning folder, Map rework), Guide; Stage, Stage contract and Work ticket adjusted.

### Handed on

- **14**: maps end in a destination that hands slices to specs; use the plan levels and "map rework" when closing maps.
- **Directory and design**: paths for research notes, guides, planning folders, the knowledge drop folder, trial files (09) and session notes (39).
- **Roadmap items**: the four rollout pieces above; this repo's `AGENTS.md` CHANGELOG rule and `/end-session` get the short-line form.
