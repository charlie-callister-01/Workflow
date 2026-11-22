# Interpretable Context Methodology (ICM)

## Question

What is Jake Van Clief's Interpretable Context Methodology, what problem does it solve, how does it compare with this toolbox's `CLAUDE.md` + `docs/agents/*.md` approach, and what is worth taking?

## Sources

- Repo: <https://github.com/RinDig/Interpretable-Context-Methodology> (MIT, ~1.5k stars, created 2026-02-22, last push 2026-10-06). Read via `gh api`: `README.md`, `CLAUDE.md`, `_core/CONVENTIONS.md`, `_core/placeholder-syntax.md`, `workspaces/course-deck-production/{CLAUDE.md,CONTEXT.md,stages/02-curriculum/CONTEXT.md}`, file tree, commit log.
- Paper: Van Clief and McDermott, *Interpretable Context Methodology: Folder Structure as Agentic Architecture*, arXiv:2603.16021 (v2, 2026-03-18): <https://arxiv.org/abs/2603.16021>. Abstract only read.
- Origin system named in the README: <https://github.com/RinDig/Content-Agent-Routing-Promptbase> (not read).
- No videos or blog posts are linked from the repo; none used.

## What I learned

**What it is.** "Folder structure as agent architecture." A *workspace* is a folder: numbered stage folders (`stages/01-research/`, `02-script/`, ...) each holding a `CONTEXT.md` (the stage's prompt), `references/` (stable rules) and `output/` (that run's artifact). One agent walks the stages; the next stage reads the previous stage's `output/`. No framework, no code orchestration. It was called Model Workspace Protocol (MWP) until March 2026 and the old name still appears in `CONVENTIONS.md` and the paper abstract.

**Problem it solves.** Multi-agent frameworks (CrewAI, LangChain, AutoGen) cost engineering effort to change. For workflows that are *sequential, reviewed by a human at each step, and repeated with new input* (content production, reports, course decks), files and folders are enough. Side benefits it claims: observable by default (state is the filesystem), portable (copy the folder), diffable in git, and smaller context per step (2-8k tokens per stage instead of 30-50k monolithic). It says plainly it does not fit real-time multi-agent loops, high concurrency, or automated branching.

**Five-layer context loading** (agents read down and stop when they have enough):

| Layer | File | Question | Loaded |
|---|---|---|---|
| 0 | `CLAUDE.md` | Where am I? | always (~800 tokens) |
| 1 | workspace `CONTEXT.md` | Where do I go? | on entry (~300) |
| 2 | stage `CONTEXT.md` | What do I do? | per task (200-500) |
| 3 | `references/`, `shared/`, `skills/`, brand/design folders | What rules apply? | selectively; stable across runs ("the factory") |
| 4 | `output/`, source material | What am I working with? | selectively; changes every run ("the product") |

**Stage contract** (`CONTEXT.md`, "no exceptions"): `## Inputs` table (Source, File, *Section/Scope*, Why), `## Process` numbered steps, `## Outputs` table. Creative stages add `## Checkpoints` (After step / Agent presents / Human decides) and `## Audit` (Check / unambiguous Pass condition; fix before writing output).

**The 15 conventions worth noting** (`_core/CONVENTIONS.md`):
- *Selective section routing*: Inputs name the section of a file to load, not just the file.
- *Canonical sources*: every fact has one home; smell test is grepping a phrase and finding it authoritative in two files.
- *One-way references*: if A points to B, B never points back (keeps links from growing N-squared).
- *CONTEXT.md is routing, not content*: 25-80 lines; no rules or definitions inside.
- *Docs over outputs*: agents must not learn patterns from earlier outputs ("early outputs are the worst outputs").
- *Specs are contracts*: specify what and when, never how.
- *Questionnaire*: flat, all questions in one message, system-level only, derive what you can, defaults for everything, ask once. Answers fill `{{PLACEHOLDERS}}`; setup is done only when a scan finds zero `{{` left. Placeholders are banned from `CLAUDE.md` and routing tables so those work before setup.
- *Bundled skills*: copy needed skills into the workspace's `skills/` so it is self-contained.
- *Guardrails*: CONTEXT.md under 80 lines, reference files under 200, plain English, `.gitkeep` in empty folders.
- Triggers are plain keywords in `CLAUDE.md` (`setup`, `status`); `status` renders an ASCII pipeline from which `output/` folders are non-empty.
- Workspace `CLAUDE.md` carries a **What to Load / Do NOT Load** table per task.

A `workspace-builder` workspace builds new workspaces through five stages (discovery, mapping, scaffolding, questionnaire design, validation).

### Compared with this toolbox

| | ICM | This toolbox |
|---|---|---|
| Domain | repeatable content/production pipelines | software development, one change at a time |
| Layer 0 | `CLAUDE.md` routing table | `CLAUDE.md` "Start here" + repo map (template capped at ~120 lines) |
| Process lives in | stage `CONTEXT.md` files inside the repo | skills (`/start-session`, `/ship`, Matt Pocock's pipeline) |
| Stable config (Layer 3) | `references/`, `shared/`, `_config/` | `docs/agents/*.md` ("every skill reads `workflow-settings.md` first; change a value here, not in the skills") |
| Per-run state (Layer 4) | `stages/*/output/` | `.scratch/` specs and tickets, `docs/STATUS.md`, `HANDOFF.md`, `LOG.md` |
| Setup | `setup` keyword + questionnaire + placeholder scan | `/setup-workflow` (detect, ask once, copy, fill settings) |
| Selective loading | explicit Inputs tables with section scope, "Do NOT load" | prose hints ("A phase? Only `docs/phases/P-NN.md`", "grep first, read ranges") |
| Quality gate | per-stage Audit table | `/code-review`, size check, thermo-nuclear review |

The two agree on most of the philosophy: plain markdown, one canonical home per value, small entry file pointing outward, load only what the task needs, human edits between steps. The toolbox puts process in reusable **skills** (shared across repos, updated in one place); ICM puts process in **per-workspace folders** (self-contained, editable by non-developers). For software work, where steps are not a fixed linear pipeline, skills are the better fit; ICM's numbered stage folders would be a poor replacement for the grill -> spec -> tickets -> implement loop.

### Agent agnosticism

Mostly agent-agnostic. Only Layer 0 relies on a Claude Code feature (auto-loading `CLAUDE.md`); everything else is markdown any file-reading agent can follow, and triggers are plain keywords, not slash commands. Bundled skills use Claude Code's `SKILL.md` layout and the builder scans `~/.claude/skills/` (and `~/.agents/skills/`). Porting to another agent would mostly mean renaming or mirroring `CLAUDE.md` as `AGENTS.md`. The toolbox is more tied to Claude Code (skills invoked via the Skill tool, plugin install).

## What I might change in the workflow

1. **"What to load / Do NOT load" table in `templates/CLAUDE.md`**: a few rows per common task (start session, implement a ticket, review, ship) naming the minimal files. Turns today's prose hints into something auditable. Cheap; high value.
2. **Placeholder scan at the end of `/setup-workflow` and `/refit-workflow`**: grep the copied templates for leftover `<...>` placeholders and ask for missing values; setup is not done until none remain. Also follow ICM's rule that the entry file must work before it is filled in.
3. **Audit tables with pass conditions** in skills that write artifacts (`to-spec`/tickets output, `/end-session` STATUS rewrite): a short Check / Pass condition list run before saving.
4. **Conventions for `docs/agents/` and `notes/`**: adopt *one-way references* (settings files never point back at skills) and the *canonical-source grep smell test* as a check in `/refit-workflow` or the thermo-nuclear review.
5. **"Docs over outputs" line** in the template's context-discipline section: agents learn conventions from `docs/` and `GLOSSARY.md`, not by copying old specs or tickets.
6. **Size caps per file type** (already ~120 lines for `CLAUDE.md`): consider a cap for each `docs/agents/*.md` (e.g. 80 lines) so they stay routing-sized.
7. **Not taking**: numbered stage folders as the process model, bundling third-party skills into each repo (conflicts with the "package as a plugin" idea), and `{{PLACEHOLDER}}` syntax (our `<...>` style is fine).
8. **Maybe later**: an ICM-style workspace as a separate *preset* or template for non-code repeatable work (reports, day-log roll-ups), where a fixed linear pipeline does fit.

Link from `../ideas.md` when any of 1-6 is picked up.
