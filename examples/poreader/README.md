# Example: PoReader

The project this workflow came from: a C#/.NET app that reads purchase-order PDFs with rule parsers and a local LLM and turns them into an ERP sales-order draft. Solo, synthetic data only. Organisation, customer and system details are left out.

## Choices

- **Preset:** `full`, with the fast lane for docs and small fixes.
- **Platform:** `azure`. Azure DevOps holds the repo, PRs and the CI pipeline (build, test, format check). `main` has a branch policy: one reviewer (self-approval allowed) and required build validation. The GitHub copy is an archive only.
- **Optional skills:** all four (`pr-explainer`, `thermo-nuclear-code-quality-review`, `day-log`, `vault-note`), with an Obsidian vault on OneDrive.

## How it is laid out

```
CLAUDE.md                  rules (under ~120 lines)
CODING_STANDARDS.md        read by reviews
GLOSSARY.md                domain terms
docs/STATUS.md             where we are (rewritten each session)
docs/HANDOFF.md            2-4 files to read next
docs/LOG.md                one line per session
docs/PLAN.md               12 phases
docs/phases/R-NN.md        phase + Specs list (R = replacement plan; P-NN in the templates)
docs/adr/                  decisions
docs/REFACTOR.md           the one refactor backlog (from phase-end reviews)
docs/explainers/           PR explainers (HTML)
docs/agents/               issue tracker, triage labels, domain docs
.scratch/rNN-<slug>/       spec.md + issues/NN-slug.md; archived per phase
tools/New-AzurePr.ps1      the only way PRs are opened
```

## What it taught (feeds `notes/`)

- Session start costs ~3-4k tokens because STATUS holds state and HANDOFF only points. Duplicated state went stale fast.
- Slicing a phase's specs as you go beat writing them all up front: early specs went stale.
- `implement` (one ticket at a time) is the default; `implement-spec` burns tokens faster and is for when time matters more.
- The Boards mirror (phases and specs, by hand) is an experiment, reviewed after a few phases.
- Docs-only pushes to `main` skip the main CI run, to save pipeline minutes.
- Windows details matter: PowerShell 5.1 and UTF-8, ASCII-only Azure PR text, `az` needing a new terminal.

See `notes/workflow-guide.md` for the full map, and `notes/decisions/` for why it is set up this way.
