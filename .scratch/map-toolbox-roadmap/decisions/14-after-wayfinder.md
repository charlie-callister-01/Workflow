# Closing work: maps and specs

Type: grilling
Style: nail
Status: resolved
Blocked by: 13, 10

## Question

When a map's frontier is empty: who writes the destination, when the map branch gets its PR, how the map moves to `.scratch/archive/`, and how the destination hands over to change flows (each roadmap item or Phase 1 spec -> which flow). Also review decision 0005 (still "exploring"): it says wayfinder is for `full` project starts only, but this first run used it in a `lite` repo for the toolbox's own future and kept research in `notes/research/` instead of `research/` branches. Keep, tune or drop?

## From 35 (2026-11-24)

A map for an effort that spans repos (like setting up home and knowledge) may live in home rather than a project; decide where maps live and how decision 0005's scope ("`full` project starts only") changes.

## Map refit (2026-11-24)

Session H. Takes in from 15: what happens to a spec folder and its work tickets after merge (archive, or fold into living docs). From 09: when a cycle is a light refresh versus a new wayfinder map. OpenSpec is parked, not a research ticket.

## From the inbox (2026-11-25)

Before the roadmap hands over to change flows, review its design: the architecture review on plans (34's inbox note) applied to the roadmap before Phase 1 is sliced, ideally with a doubt-driven pass from a separate context.

## From 40 (2026-11-26)

If 10's planning stage-folder trial is kept, closing a piece of work means archiving its effort folder as one unit (all stages and their contracts together).

## From 10 (2026-11-27)

Plan levels are now fixed for every repo (glossary): Roadmap > Phase (`P1`) > Slice (`P1-a`, thin and end-to-end) > Map or Spec > Planning folder > Ticket. A map that ends in a roadmap hands each slice on to a map or a spec; reshaping a map part-way is a **map rework** ("refit" is only `/refit-workflow`). Closing a map writes its destination in these levels.

## Answer

Resolved 2026-11-27 (grilling, `nail`: five questions, all accepted as recommended). Decision 0021 supersedes 0005.

### Picks

| Source | Taken | Dismissed or parked |
|---|---|---|
| Pocock | `wayfinder`'s finish condition (nothing left to decide) and hand-off signal (the pull to do the work); out of scope never graduates. | - |
| Osmani | Doubt-driven review of the destination from a fresh context before hand-off. | - |
| pstack / fstack | A map is a loop: an explicit finish condition, with Decisions so far and the tickets as its decision log, archived intact; dismissed objections kept with reasons. | - |
| ICM | Archive a piece of work as one unit; the destination links one way to the archived map and never restates tickets; git is the history. | OpenSpec's "fold specs into living specs" stays parked (not a primary source). |

### Decisions

1. **Closing and the destination.** A map closes when its frontier and its fog are both empty; Out of scope stays listed and never blocks closing. The map's **last decision ticket** writes the destination in its own session (for this map: Roadmap phases). The map gets `Status: closed` and a closing line in Decisions so far linking the destination.
2. **Branch, PR and review.** No long-lived map branch: one branch and PR per session (15), as this map has run. The **closing PR** carries the destination, the archive move and the CHANGELOG line. When the destination is a roadmap or a plan, two fresh-context subagents review it before that PR: an **architecture review** (`codebase-design`) and a **doubt pass** that tries to disprove it; dismissed objections are kept with reasons in the last ticket's answer. For this map, Roadmap phases becomes `Style: doubt` plus the architecture review.
3. **Archive.** The closing PR moves the whole map folder as one unit with `git mv` into the archive (path decided by Directory and design; today `.scratch/archive/map-<effort>/`). Archived folders are never loaded (`/start-session` already skips them). A spec or planning folder is archived the same way when its last work ticket merges. Nothing is folded into living docs at the end: glossary terms, ADRs and guides are updated while the work happens. Archive rather than delete, so links from ADRs and the destination keep working.
4. **Hand-over to change flows.** The destination is written in 10's plan levels. Each **slice** line names its planning route, picked by 34's signal table (a spec through the new feature or small feature flow, a new map when its decisions can't be listed yet, or straight to a small change) and its status. The roadmap is then a living doc: a **roadmap refresh** (reorder, add, remove, mark done) is a small change made in place; a question that can't be listed yet gets a new map, and a closed map is never reopened.
5. **Decision 0005.** Superseded by 0021. Wayfinder is a planning method in any repo, chosen by 34's signal table, with no tie to presets (retired by 37). Research runs inside the session and goes to research notes, no `research/` branches. A map lives in the repo whose files it will change; a map spanning repos lives in **home**, and each repo's slices are handed to that repo.

Glossary: Map and Destination adjusted; Roadmap refresh added.

### Handed on

- **Roadmap phases**: `Style: doubt` plus the architecture review; writes `notes/roadmap.md` with each slice's route and status; its closing PR archives this map.
- **Directory and design**: the archive path for maps, specs and planning folders; where home keeps maps that span repos.
- **Roadmap items**: setup and refit stop tying wayfinder to preset `full` (`skills/setup-workflow` step 9, `presets/full.md`, which 37 deletes) and offer it by 34's signal table; the wayfinding operations in `docs/agents/issue-tracker.md` gain the closing steps (close, archive, no `research/` branches).
