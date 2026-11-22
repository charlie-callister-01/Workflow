# Workflow

My software development and AI workflow, as a toolbox: Claude Code skills, project templates, presets for different ways of working, and notes on how the workflow itself develops.

It started as the workflow of one real project (see `examples/poreader/`) and is now a base to improve on. Nothing here is final.

## The pipeline at a glance

```
/start-session            where are we? (STATUS + HANDOFF, open PRs, next step)
  /grill-with-docs        think: questions until we agree; glossary + ADRs
  /to-spec, /to-tickets   plan: one spec, small tickets in .scratch/
  /implement              build: ticket by ticket, test first
  /code-review            check: standards + spec
  size check              big fix work -> a fix spec instead
  /ship                   PR: body, explainer for code, platform PR command
/end-session              STATUS, HANDOFF, one LOG line, re-slice the phase
/day-log                  (optional) end-of-day note in the vault
```

How much of this you use depends on the **preset** (`presets/`), and where PRs and CI live depends on the **platform** (`platforms/`). The two are chosen separately.

| Preset | For |
|---|---|
| `full` | multi-week projects with phases; context must survive many sessions |
| `fast-lane` | docs, config, small fixes inside a `full` project |
| `lite` | small personal projects and spikes |
| `team` | later |

| Platform | For |
|---|---|
| `github` | personal projects: `gh`, GitHub Actions, light process |
| `azure` | work projects: Azure DevOps PRs, pipelines, Boards; heavier, team-ready later |

## Skills in this repo

| Skill | Tier | What it does |
|---|---|---|
| `start-session` | core | Branch check, read STATUS + HANDOFF, open PRs, propose the next step |
| `end-session` | core | Rewrite STATUS + HANDOFF, one LOG line, re-slice the phase, branch sweep at phase end |
| `ship` | core | The one way to open a PR: body, explainer for code, platform PR command |
| `pr-explainer` | optional | HTML explainer of a branch (teacher + senior engineer voice) as an Artifact |
| `thermo-nuclear-code-quality-review` | optional | Very strict maintainability review at the end of a phase |
| `day-log` | optional | End-of-day note in an Obsidian vault |
| `vault-note` | optional | A lesson or decision summary in an Obsidian vault |

## Skills from elsewhere (install, don't copy)

The pipeline leans on Matt Pocock's skills, installed as a Claude Code plugin: <https://github.com/mattpocock/skills>. The ones this workflow uses most:

| Skill | Used for |
|---|---|
| `grilling` | questions in rounds, each with a recommended answer, until we agree |
| `grill-with-docs` | grilling + `domain-modeling`: updates `GLOSSARY.md` and offers ADRs as terms settle |
| `to-spec`, `to-tickets` | turn the grill into a spec and small tickets in `.scratch/` |
| `implement` / `implement-spec` | build ticket by ticket (default), or in parallel subagents (costs more) |
| `tdd` | red-green-refactor |
| `code-review` | review against the coding standards and the spec |
| `pr` | write the PR body |
| `wayfinder` | map a very foggy piece of work before speccing it |
| `diagnosing-bugs`, `prototype`, `research` | as needed |

## Repo layout

```
README.md        this file
SETUP.md         set up a new or existing project
CUSTOMISING.md   every setting, and the ways to change the workflow
CHANGELOG.md     how the workflow has changed, and why
skills/          my skills (copy into .claude/skills/)
templates/       CLAUDE.md, docs/ state files, docs/agents/*
presets/         full, fast-lane, lite, team (later)
platforms/       github, azure
tools/           New-AzurePr.ps1, gh-pr.md, Export-StandaloneHtml.ps1
examples/        poreader: the project this came from
notes/           research, ideas and decisions for developing the workflow itself
```

Start with `SETUP.md`.
