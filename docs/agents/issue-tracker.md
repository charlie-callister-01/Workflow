# Issue tracker: Local Markdown

Specs and tickets live as markdown files in `.scratch/`. Markdown is the source of truth because the skills read it. Any board (Azure Boards, GitHub Projects) is a one-way mirror, if used at all (see `docs/agents/platform.md`).

## Conventions

- One spec per directory, named with its phase first: `.scratch/pNN-<spec-slug>/` (fix specs `pNN-fix-<slug>`). Preset `lite`: no phase prefix.
- The spec is `.scratch/pNN-<spec-slug>/spec.md`. Each spec is one line in the Specs list of its phase file `docs/phases/P-NN.md`.
- Implementation tickets are one file each at `.scratch/pNN-<spec-slug>/issues/<NN>-<slug>.md`, numbered from `01`, never a single combined file.
- Triage state is a `Status:` line near the top of each spec or ticket holding **exactly one** label from `triage-labels.md` (or `resolved`). Any detail goes on its own `Notes:` line underneath, never inside the Status line.
- Comments and history append to the bottom of the file under `## Comments`.
- Durable outcomes (decisions, status) are copied into `docs/adr/`, `docs/STATUS.md` and `docs/LOG.md`; `.scratch/` is working space.
- When a phase closes, move its `.scratch/pNN-*` folders to `.scratch/archive/` (move, never delete).

## When a skill says "publish to the issue tracker"

Create a new file under `.scratch/pNN-<spec-slug>/` (create the directory if needed) and add or update the spec's line in `docs/phases/P-NN.md`.

## When a skill says "fetch the relevant ticket"

Read the file at the referenced path. The user will normally pass the path or the ticket number. Archived work is under `.scratch/archive/`.

## Wayfinding operations

Used by `/wayfinder` for foggy efforts. Its tickets are **decision tickets** (questions to decide), never **work tickets** (slices of a spec to build): they live apart. The map is `.scratch/map-<effort>/map.md`; each decision ticket is `.scratch/map-<effort>/decisions/NN-<slug>.md` with a `Type:` line (`research`/`prototype`/`grilling`/`task`), for grilling a `Style:` line (`rounds`/`nail`/`interview`/`doubt`, default `rounds`), a `Status:` line (`open`/`claimed`/`resolved`) and a `Blocked by: NN, NN` line. Frontier = open, unblocked, unclaimed files, first number wins. Claim by setting `Status: claimed` before work; resolve by appending an `## Answer` section, setting `Status: resolved`, and adding a pointer to the map's Decisions-so-far.
