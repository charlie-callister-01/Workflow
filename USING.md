# Using the workflow in a project

How to work in a project once `/setup-workflow` has primed it. For setting it up, see [SETUP.md](SETUP.md). For the full picture with diagrams, see [notes/workflow-guide.md](notes/workflow-guide.md).

## What the project now has

| File or folder | What it is | Preset |
|---|---|---|
| `AGENTS.md` | The rules agents follow in this project: commands, branch rules, the pipeline | all |
| `CLAUDE.md` | One line, `@AGENTS.md`: Claude Code imports `AGENTS.md`; other agents read it directly | all |
| `docs/agents/workflow-settings.md` | Your answers from setup: preset, platform, owner, test command, PR commands | all |
| `docs/agents/*.md` | Where tickets live, triage labels, domain docs, platform rules (read by Matt Pocock's skills) | all |
| `docs/LOG.md` | One line per session | all |
| `.claude/skills/` | `start-session`, `end-session`, `open-pr`, plus any optional skills you picked | all |
| `docs/STATUS.md` | Where the project is right now (about 40 lines) | `full` |
| `docs/HANDOFF.md` | What the next session should read first (about 10 lines) | `full` |
| `docs/PLAN.md`, `docs/phases/P-NN.md` | The plan, and each phase's Specs list | `full` |
| `.scratch/` | Specs and tickets being worked on | `full` |
| `docs/adr/`, `GLOSSARY.md` | Decisions and domain terms, created as they come up | `full` |

Not sure which preset a project uses? Look at `preset:` in `docs/agents/workflow-settings.md`.

## A normal session

**Every session starts and ends the same way:**

1. `/start-session`: checks the branch is current, shows open PRs and suggests the next step.
2. Do the work (see below).
3. `/open-pr` when a change is ready: it writes the PR body and opens the PR. You merge it.
4. `/end-session`: writes one line in `docs/LOG.md` (and in `full`, updates STATUS and HANDOFF).

**`lite` project:** idea -> branch -> build (`/mattpocock-skills:tdd` if it has tests) -> `/open-pr` -> merge -> `/end-session`.

**`full` project:**

```
/grill-with-docs      agree what to build; GLOSSARY and ADRs update as you go
/to-spec              write the spec into .scratch/
/to-tickets           slice it into small tickets
/implement            build ticket by ticket, test first
/code-review          check against the coding standards and the spec
/open-pr                 open the PR
```

Small changes in a `full` project (docs, config, fixes under about 30 lines) skip straight to `/open-pr`: that is the `fast-lane` preset.

## What do I do when...

| Situation | Do this |
|---|---|
| I have an idea but it's vague | `/mattpocock-skills:grilling` until it's clear |
| The way from idea to plan is really foggy | `/mattpocock-skills:wayfinder` with the idea: it charts a map of decisions first |
| Something is broken | `/mattpocock-skills:diagnosing-bugs` |
| I want to try a design quickly | `/mattpocock-skills:prototype` (throwaway) |
| I need facts from docs or the web | `/mattpocock-skills:research` (writes a note) |
| A code review found a lot to fix | follow the size check: big fix work becomes its own fix spec |
| A phase is finished (`full`) | `/thermo-nuclear-code-quality-review` if installed; refactors go to `docs/REFACTOR.md` |
| Something is worth remembering | `/vault-note` (if you use a vault), or a line in the project's notes |
| End of the day | `/day-log` (if installed) |
| The toolbox has changed and I want the updates | `/refit-workflow` in the project: it shows what changed since `workflow_version` |
| The project outgrew its preset | `/refit-workflow` and choose the new preset |
| I work in it with more than one agent | Tag each LOG line with the agent: `## YYYY-MM-DD [antigravity]: ...`. Trying a new agent: copy `notes/trials/agent-trial-template.md` from the Workflow repo |

## Rules that always hold

- Never commit to `main`. Branches are `feature/`, `fix/`, `chore/`.
- Open PRs only with `/open-pr`. It picks squash (docs) or merge commit (code).
- If STATUS and git disagree, trust git.
- Agents read only what they need: `AGENTS.md`, STATUS and the files HANDOFF lists. Everything else on demand.
- Archive, don't delete.

## Changing how a project works

- A setting (test command, vault folder, PR commands): edit `docs/agents/workflow-settings.md`. See [CUSTOMISING.md](CUSTOMISING.md).
- A skill: change it in the Workflow repo, not in the project, then pull it in with `/refit-workflow`. Edits made only in a project are lost on the next refresh.
