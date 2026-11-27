# Directory and design

Type: grilling
Style: rounds
Status: resolved
Blocked by: 09, 10, 14

## Question

Where does everything live? Decide the design rules for folders and file names, then every path the resolved tickets left provisional: the toolbox's own layout (guides, seeds, migrations, trial files, research), what a primed project carries and where (durable docs versus working files: maps, specs, planning folders, session notes, the archive), what home holds beyond 42's layout (markers, reviews, maps that span repos), the context layers each repo presents (40), and the form of the directory map page (every folder, which skill reads or writes it, a load / don't-load table per flow). The knowledge repo's own layout is decided in that repo.

## From the map (graduated 2026-11-27)

Fog patch, the owner's (2026-11-27): the final layout of every folder and file across the toolbox, home, knowledge and projects, the context layers each repo presents, and the design rules behind them; decided last, once the rest is set up. Absorbs the directory map page item.

Handed on here: the session note's location (39; provisionally `.scratch/sessions/<branch>.md`); `notes/trials/`, home's `markers/` and `reviews/` (09); paths for research notes, guides, planning folders and the knowledge drop folder (10); the archive path for maps, specs and planning folders, and where home keeps maps that span repos (14).

## Answer

Resolved 2026-11-27 (grilling, `rounds`: three rounds; the owner redirected round 1 from `.scratch/` to an ICM-style workspace). Decision 0022.

### Picks

| Source | Taken | Dismissed or parked |
|---|---|---|
| Pocock | `docs/adr/`, `docs/agents/` and `GLOSSARY.md` at the root kept where his skills expect them; his skills reach the workspace through the tracker doc. | `.scratch/` as the working root: replaced by the workspace (his default path, so checked in the trial). |
| ICM | A durable folder holding every planning input and output, its folders following the context layers; routing `CONTEXT.md` files; numbered folders; one home per fact. | Routing files in every folder: only the workspace root and each map or spec. |
| Osmani | A short repo map in `AGENTS.md` (layer 0); docs as references. | - |

### Decisions

1. **Agent workspace.** Every repo (toolbox, home, projects) gets `workspace/`, which replaces `.scratch/`: the planning and context work, kept and committed, never code. Inside: `CONTEXT.md` (routing, layer 1: what is active, pointers), `roadmap.md` (phases and slices), `maps/<effort>/` (`map.md`, `decisions/NN-slug.md`), `specs/<NN-slug>/` (`CONTEXT.md`, `01-grill/`, `02-spec/`, `03-tickets/`), `research/YYYY-MM-DD-slug.md`, `sessions/<branch>.md` (session notes, `/` in branch names becomes `-`; 39's fold-and-delete rule stands) and `archive/` (closed maps and specs, moved whole, 14).
2. **Outside the workspace**, for now: `AGENTS.md`, `GLOSSARY.md`, `CHANGELOG.md` and the guide files at the root; `docs/agents/` (settings, tracker, domain), `docs/adr/` and `docs/LOG.md`. Direction (owner): later, toolbox skills based on Pocock's write into the workspace natively, and these can move in; a later-phase roadmap item with its own decision, since it revisits 05's "Pocock and built-ins win".
3. **Pocock's skills.** `docs/agents/issue-tracker.md` points local tickets at `workspace/specs/<spec>/03-tickets/` and maps at `workspace/maps/`; the trial checks his skills follow it, and any that hardcode `.scratch/` go in 05's adoption table.
4. **Routing files.** A routing `CONTEXT.md` at the workspace root and in each map and spec folder (what is here, what is current, what to load next); stage contracts only in a spec's numbered planning folders (10); none in `research/`, `sessions/` or `archive/`. Widens 10's planning-folder trial into one **workspace module** trial.
5. **One layout everywhere.** The toolbox follows the project layout for anything a project also has (ADRs in `docs/adr/`, research in `workspace/research/`, `docs/LOG.md`); toolbox-only folders sit at the root: `skills/`, `templates/`, `seeds/`, `migrations/`, `guides/`, `beta/`, `platforms/`, `tools/`. `notes/` keeps only toolbox development: `ideas.md`, `trials/<slug>.md` (09), `v1.md`.
6. **Naming.** Lowercase kebab-case, no spaces; `NN-slug` where order matters (tickets, planning folders, specs); `NNNN-slug` for ADRs and migrations; `YYYY-MM-DD-slug` for dated notes; `YYYY-Www` for weekly reviews; UPPERCASE only for the well-known root files and `docs/LOG.md`.
7. **Context layers**, the same in every repo: 0 `AGENTS.md` (home adds `## Other repos`); 1 `docs/agents/workflow-settings.md`, the LOG tail, `workspace/CONTEXT.md`, the active map, this branch's session note; 2 the stage's skill or a planning folder's stage contract; 3 `docs/agents/*.md`, `GLOSSARY.md`, `docs/adr/` (only when listed); 4 workspace working files and code (only those named).
8. **Home.** `workspace/maps/<effort>/` for maps spanning repos (14), `workspace/reviews/YYYY-Www.md` for the weekly review (09); per-machine capture files at the root beside 42's `inbox/`: `markers/<machine>.csv`. The knowledge drop folder is decided in the knowledge repo (42).
9. **Repo maps.** Each `AGENTS.md` keeps a hand-written repo map of about 5 lines (layer 0). A candidate toolbox skill, `/map-repo`, writes `docs/agents/repo-map.md` (every folder, its layer, the skills that read or write it), committed so a PR diff shows layout changes, prints a drift report (folders off the layout, names breaking the rules) and ends with an audit table (31). The toolbox's own run is the full directory map; no hand-kept guide. A candidate module, kept only if used.
10. **Rollout.** The toolbox goes first, without moving live paths mid-map: this map's closing PR moves `.scratch/map-toolbox-roadmap/` to `workspace/archive/maps/toolbox-roadmap/`, writes `workspace/roadmap.md` (not `notes/roadmap.md`), moves `notes/research/` to `workspace/research/` with names fixed, `.scratch/architecture-deepening/` to `workspace/archive/specs/`, and `notes/decisions/` to `docs/adr/`. Projects get the workspace through the workspace module trial (with 10's planning folders) and a migration (23) for `.scratch/`.

Glossary: Agent workspace, Routing file added; Map adjusted.

### Handed on

- **05**: a note that the later Pocock-based skills revisit "Pocock and built-ins win".
- **Roadmap phases**: writes `workspace/roadmap.md`; its closing PR does point 10's toolbox moves.
- **Roadmap items**: the workspace module trial (with the planning-folder trial, the tracker doc, the `.scratch/` migration); `/map-repo` as a candidate module (replaces the directory map page item); Pocock-based skills writing into the workspace, a later phase.
