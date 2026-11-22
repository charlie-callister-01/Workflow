# Developing the toolbox

How to improve this repo: where research, ideas and learning go, how a change gets made, and how it reaches projects. For using the workflow inside a project, see [USING.md](USING.md).

## The loop

The toolbox is never finished. Everything moves round the same loop:

```
idea  ->  research  ->  decide  ->  change  ->  try on a project  ->  keep, tune or drop
 ^                                                                          |
 +--------------------------------------------------------------------------+
```

1. **Idea:** a line in [notes/ideas.md](notes/ideas.md). That file is the inbox; anything goes.
2. **Research** (if needed): a note in [notes/research/](notes/research/), one file per topic, `YYYY-MM-DD <topic>.md`. `/mattpocock-skills:research` writes these.
3. **Decide:** grill it (`/mattpocock-skills:grilling`). A real trade-off gets a short note in [notes/decisions/](notes/decisions/).
4. **Change:** edit the skill, template, preset or platform on a branch, add a line to [CHANGELOG.md](CHANGELOG.md), `/ship`.
5. **Try it** on a real project. Keep it, tune it, or strike it through in `ideas.md` with why.

Bigger or foggy questions go through a **wayfinder map** instead of one grill: see below.

## Where things go

| I have... | It goes in |
|---|---|
| A thought, plan or "should try X" | `notes/ideas.md` |
| Findings about a tool, method, article or another person's skills | `notes/research/YYYY-MM-DD <topic>.md` |
| Notes on a book | `notes/research/` for now; a learning section is being decided (roadmap ticket 08) |
| A decision with a real trade-off | `notes/decisions/NNNN-<slug>.md` |
| A change that shipped | one line in `CHANGELOG.md` |
| A big, foggy question | a wayfinder map in `.scratch/<effort>/` |
| A new skill | `skills/<name>/SKILL.md` (see CUSTOMISING.md, "Writing a new skill") |

## Where it's up to: the roadmap map

The current big effort is the **toolbox roadmap**: [.scratch/toolbox-roadmap/map.md](.scratch/toolbox-roadmap/map.md). It ends with `notes/roadmap.md` v1.

- **Decisions so far** lists every resolved ticket with a one-line answer.
- **Tickets** are in `.scratch/toolbox-roadmap/issues/`. `Status: open` and nothing in `Blocked by` that is still open means it can be worked now.
- **Not yet specified** holds what's coming but not clear enough to ticket yet.

To work the next ticket, start a fresh session and run:

```
/mattpocock-skills:wayfinder .scratch/toolbox-roadmap/map.md
```

It picks the first open ticket (or name one), works it with you, records the answer and updates the map. One ticket per session.

## Making a change

1. `/start-session`, then a branch: `feature/<name>`, `fix/<name>` or `chore/<name>`.
2. Edit in `skills/`, `templates/`, `presets/`, `platforms/` or `tools/`. **Never edit `.claude/skills/`**: those are this repo's own installed copies.
3. Add a `CHANGELOG.md` line; a decision note if it was a real trade-off.
4. Refresh what's installed:
   - Changed `setup-workflow` or `refit-workflow`: `powershell -File tools/Install-GlobalSkills.ps1`
   - Changed a core skill: delete its copy in `.claude/skills/`, then `powershell -File tools/Install-Workflow.ps1 -Project . -Preset lite -Platform github -Skills core`
   - Changed the install script: dry run into an empty temp folder with `-DryRun`.
5. `/ship`. Merge with **squash** for notes and docs, **merge commit** for `skills/`, `tools/`, `templates/`.
6. `/end-session`.

## How changes reach projects

Each project records the toolbox commit it was set up from (`workflow_version` in its `docs/agents/workflow-settings.md`). Running `/refit-workflow` in a project shows what changed since then and merges it in without overwriting the project's own edits. A smoother update flow is on the roadmap.

## Rules for this repo

- Personal repo on GitHub: never add employer, customer or personal details.
- PowerShell scripts must run on 5.1 and read and write UTF-8 explicitly.
- Keep skills short: numbered steps, settings by name, facts from git and the platform.
