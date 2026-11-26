# Workflow

My toolbox for software development with AI agents: skills, project templates, presets for different ways of working, and my research and notes on how to work better. One repo I improve over time, and copy into every project I work on.

It started as the workflow of one real project (`examples/poreader/`) and is built around [Matt Pocock's skills](https://github.com/mattpocock/skills). Nothing here is final.

## Where to start

| I want to... | Read |
|---|---|
| See where the toolbox is up to | [Where I'm up to](#where-im-up-to) below |
| Put the workflow into a new or existing project | [SETUP.md](SETUP.md) (about 15 minutes, mostly one command) |
| Use it day to day inside a project | [USING.md](USING.md) |
| Improve the toolbox itself (research, ideas, new skills) | [DEVELOPING.md](DEVELOPING.md) |
| Change a setting or knob | [CUSTOMISING.md](CUSTOMISING.md) |
| See what changed and why | [CHANGELOG.md](CHANGELOG.md), [notes/decisions/](notes/decisions/) |

## Where I'm up to

_Last updated 2026-11-23._

### v1: tagged

Presets `full`, `fast-lane`, `lite`; platforms `github` and `azure`; `/setup-workflow` primes a project in one command, `/refit-workflow` merges into a repo that already has a workflow. Tagged `v1.0`; projects primed from it keep working. Summary: [notes/v1.md](notes/v1.md).

### v2: in planning, first change in

What `skills/`, `templates/`, `presets/` and `platforms/` hold now is v1 plus the v2 changes promoted so far:

- **`AGENTS.md` is the instruction file** and `CLAUDE.md` is one line, `@AGENTS.md`, so every agent reads the same rules (decision 0006; trialled on the beta track).

The rest is being charted as a wayfinder map: [.scratch/map-toolbox-roadmap/map.md](.scratch/map-toolbox-roadmap/map.md), ending in `notes/roadmap.md`.

- **Done:** research on Addy Osmani's agent-skills, Cursor's pstack and team kit, ICM, a survey of other skill sets, and two books (The Pragmatic Programmer, Domain-Driven Design), and the owner's ICM research (context layers, planning stage folders on trial). Decided: verification (a check run and shown for every code change, set per project in a Checks section; decision 0014) and shipping (one PR per session, Show for docs, Ask for code; decision 0015) and routing (a flow table and skill descriptions, no router skill; decision 0016). Vocabulary in [GLOSSARY.md](GLOSSARY.md).
- **Next decisions:** updating the workflow in older projects; change flows (start project, new feature, small feature, small change, bug fix, spike) and repo profiles in place of presets; what happens after wayfinder and after implementation; what to adopt from the research; projects with more than one agent; a learning section; organising and exporting research and lessons; a status page I can read.

To continue: `/mattpocock-skills:wayfinder .scratch/map-toolbox-roadmap/map.md`.

## The pipeline at a glance

A project's work flows like this. How much of it you use depends on the **preset**.

```
/start-session            where are we? (branch, open PRs, next step)
  /grill-with-docs        think: questions until we agree; glossary + ADRs
  /to-spec, /to-tickets   plan: one spec, small tickets in .scratch/
  /implement              build: ticket by ticket, test first
  /code-review            check: standards + spec
  /open-pr                PR: body, explainer for code, platform PR command
/end-session              STATUS, HANDOFF, one LOG line
/day-log                  (optional) end-of-day note in the vault
```

| Preset | For |
|---|---|
| `full` | multi-week projects with phases; context must survive many sessions |
| `fast-lane` | docs, config and small fixes inside a `full` project |
| `lite` | small personal projects and spikes |
| `team` | later |

| Platform | For |
|---|---|
| `github` | personal projects: `gh`, GitHub Actions, light process |
| `azure` | work projects: Azure DevOps PRs, pipelines, Boards |

Preset and platform are chosen separately. Details: `presets/`, `platforms/`.

## Skills

**My skills** (in `skills/`):

| Skill | Tier | What it does |
|---|---|---|
| `start-session` | core | Branch check, read STATUS + HANDOFF, open PRs, propose the next step |
| `end-session` | core | Update STATUS + HANDOFF, one LOG line, re-slice the phase |
| `open-pr` | core | The one way to open a PR: body, explainer for code, platform PR command |
| `pr-explainer` | optional | HTML explainer of a branch as an Artifact |
| `thermo-nuclear-code-quality-review` | optional | Very strict maintainability review at the end of a phase |
| `day-log` | optional | End-of-day note in an Obsidian vault |
| `vault-note` | optional | A lesson or decision summary in an Obsidian vault |
| `setup-workflow` | global | Prime a repo: detect the stack, ask once, copy skills and templates, fill in settings |
| `refit-workflow` | global | Merge the toolbox into a repo that already has a workflow, or update a primed repo |

Core and optional skills are **copied into each project**. Global skills are **installed once per machine** into `~/.claude/skills/`.

**Matt Pocock's skills** (installed as a plugin, never copied; see SETUP.md): `grilling`, `grill-with-docs`, `to-spec`, `to-tickets`, `implement`, `tdd`, `code-review`, `pr`, `wayfinder`, `research`, `prototype`, `diagnosing-bugs`, `domain-modeling`.

## Repo layout

```
README.md          this page
SETUP.md           put the workflow into a project
USING.md           use it day to day in a project
DEVELOPING.md      improve the toolbox itself
CUSTOMISING.md     every setting and knob
CHANGELOG.md       one line per change, newest first
GLOSSARY.md        the toolbox's own terms (decision ticket, work ticket, repo profile, change flow, ...)
skills/            my skills (edit here, never in .claude/skills/)
templates/         AGENTS.md (+ one-line CLAUDE.md), docs/ state files, docs/agents/* for projects
presets/           full, fast-lane, lite, team (later)
platforms/         github, azure
tools/             install scripts and PR helpers
beta/              full copies of files on trial (see notes/trials.md)
examples/          poreader: the project this came from
notes/             research, ideas, decisions, the workflow guide
.scratch/          working space: the v2 roadmap map (map-toolbox-roadmap/) and its decision tickets
docs/              this repo's own workflow files (LOG, agent settings)
.claude/skills/    copies of the core skills so this repo uses its own workflow
```
