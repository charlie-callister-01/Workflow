# Survey of skill sets and workflows

## Question

Which other agent skill sets and workflows are worth a deep look for this toolbox? Breadth over depth: a quick look at each, then a shortlist of at most 5 for later deep dives. Out of scope here (other tickets): Addy Osmani's agent-skills, Cursor's pstack / cursor-team-kit, Interpretable Context Methodology.

## Sources

All read on 2026-11-22 via `gh` (README, skill folders, releases, commits). Star counts and versions are as of that date.

- obra/superpowers: <https://github.com/obra/superpowers> (v7.0.2)
- GitHub Spec Kit: <https://github.com/github/spec-kit>, docs <https://github.github.io/spec-kit/> (v1.4.3)
- BMAD Method: <https://github.com/bmad-code-org/BMAD-METHOD>, docs <https://docs.bmad-method.org/> (v6.12.4 stable, v7 alpha on main)
- Anthropic skills: <https://github.com/anthropics/skills>; Agent Skills spec <https://github.com/agentskills/agentskills> / <https://agentskills.io>
- Matt Pocock skills: <https://github.com/mattpocock/skills>, release notes for v1.3.2 (2026-10-29) and commits on `main` to 2026-11-19
- Compound Engineering (Every): <https://github.com/EveryInc/compound-engineering-plugin> (v3.38.2)
- OpenSpec: <https://github.com/Fission-AI/OpenSpec> (v2.1.1)
- GSD Core (formerly get-shit-done): <https://github.com/open-gsd/gsd-core> (v1.22.0); old repo <https://github.com/gsd-build/get-shit-done> is archived with a redirect
- Agent OS: <https://github.com/buildermethods/agent-os> (v3.0.0)
- wshobson/agents: <https://github.com/wshobson/agents>
- Task Master: <https://github.com/eyaltoledano/claude-task-master> (last push 2026-04)
- vercel-labs/skills (`npx skills` installer): <https://github.com/vercel-labs/skills>
- Lists, for later discovery only: <https://github.com/hesreallyhim/awesome-claude-code>, <https://github.com/ComposioHQ/awesome-claude-skills>

## What I learned

| Name | What it is | Agents supported | Fit for this toolbox |
|---|---|---|---|
| [Superpowers](https://github.com/obra/superpowers) | Skills-based dev methodology: brainstorming -> worktree -> writing-plans -> subagent-driven-development or executing-plans -> TDD -> code review -> finishing-a-development-branch. Skills auto-trigger; a `using-superpowers` bootstrap makes the agent check for skills before any task. Also `verification-before-completion`, `writing-skills` (with testing), `diagnosing-superpowers` (reads a session transcript to say what went wrong). | Claude Code (official marketplace), Codex, Cursor, Gemini CLI, Copilot CLI, OpenCode and ~10 more | **High.** Closest analogue to the Matt Pocock pipeline; same plugin model; several skills map 1:1 to gaps or overlaps (`finishing-a-development-branch` vs `/ship`, verification, session diagnosis). |
| [Spec Kit](https://github.com/github/spec-kit) | Python CLI (`specify`) that installs processes into a project: SDD (`constitution -> specify -> plan -> tasks -> implement -> converge`), plus bug-fix and idea-assessment extensions. Customisation via **presets**, **extensions**, **hooks**, **workflow overlays**, **bundles** and catalogs. | ~50 integrations (Claude, Copilot, Cursor, Codex, Gemini, Kiro CLI, OpenCode, Windsurf-era tools...) | **Medium-high.** Heavier than `lite`, but its layering model (preset + extension + project-local override + "which layer supplied this file") is the most developed version of what `presets/` + `platforms/` + `Install-Workflow.ps1` do. |
| [BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD) | "Agile AI-driven development": persona agents (PM, architect, UX, dev, test), right-sized planning paths, durable briefs/architecture docs. v7 alpha moves to plain skills installed with `npx skills add`; modules for skill-building (Toolsmith), unattended epics (BMad Loop), testing, games. | Any tool that supports skills (v7); npm installer for v6 | **Medium-low.** Big, persona-heavy, in flux (v7 alpha). "Choose a planning path" is worth borrowing as an idea for presets; the rest is more process than this toolbox wants. |
| [anthropics/skills](https://github.com/anthropics/skills) | Anthropic's example and document skills (docx, pdf, pptx, xlsx, skill-creator, mcp-builder, webapp-testing, frontend-design, doc-coauthoring...) plus the Agent Skills spec and a template. Installable as a Claude Code marketplace. | Claude Code, claude.ai, Claude API; the spec at agentskills.io is cross-agent | **Medium as reference, low as workflow.** Not a dev pipeline. Useful for the spec and `skill-creator` (evals for skills) when packaging the toolbox as a plugin. |
| [Matt Pocock skills, since v1.3](https://github.com/mattpocock/skills) | Upstream. v1.3.2 (2026-10-29): subagents start with a fresh context (not a fork); `implement-spec` uses a fresh implementer per ticket; `setup-matt-pocock-skills` now wires a remote, creates triage labels, renames legacy `CONTEXT.md` to `GLOSSARY`, tracker template fixes (sub-issues, native blocking); `grilling` words questions so "yes" accepts; `diagnosing-bugs` checks a forced mutation landed; `code-review` finds standards files; `wayfinder` no triage labels / no research PRs; `chief-of-staff` keeps a dated, commit-cited wiki. On `main` after v1.3.2: new in-progress `software-factory` (vocabulary for an agent factory: tasks, runs, services) and CI that YAML-checks every SKILL.md. `retro`, `chief-of-staff`, `loop-me` are present. This machine has 1.3.1 installed. | Claude Code plugin; `npx skills` for others | **Essential.** The toolbox depends on it; `setup-workflow` replaces `setup-matt-pocock-skills`, so its template fixes need porting. |
| [Compound Engineering](https://github.com/EveryInc/compound-engineering-plugin) | 38-skill plugin around a loop: `ce-brainstorm -> ce-plan -> ce-work -> ce-compound`. `ce-compound` writes learnings to `docs/solutions/` which later plans read; `/lfg` runs the loop hands-off; git skills (`ce-commit-push-pr`, `ce-babysit-pr`, `ce-resolve-pr-feedback`); `ce-retro`, `ce-handoff`; per-repo `config.yaml`; "Compound Packs" share knowledge across repos. | 14 hosts incl. Claude Code, Cursor, Codex | **High.** The learning-capture loop and PR-shepherding skills are exactly the areas this toolbox handles with STATUS/HANDOFF/LOG and `/ship`. |
| [OpenSpec](https://github.com/Fission-AI/OpenSpec) | Lightweight SDD for brownfield: `explore -> propose` creates `openspec/changes/<name>/` (proposal, spec deltas, design, tasks) -> `apply-change` -> `archive-change` merges deltas into living specs. | 30+ tools via skills | **Medium-high.** Light enough for `lite`; "change folder, then archive into living specs" is a cleaner end-state for `.scratch/` specs than deleting them. |
| [GSD Core](https://github.com/open-gsd/gsd-core) | Meta-prompting / context-engineering framework: milestones of discuss -> plan -> execute (parallel waves, each executor a clean context) -> verify -> ship; `/gsd-onboard` for existing repos. | Claude Code, Codex, Copilot, Cursor, OpenCode, Windsurf and more | **Medium.** Phase-and-milestone model overlaps the `full` preset; worth a look only if `full` needs rework. |
| [Agent OS](https://github.com/buildermethods/agent-os) | Discover standards from a codebase, inject the relevant ones per task, shape specs. | Claude Code, Cursor, Antigravity, others | **Low-medium.** "Discover standards" is a possible `setup-workflow` step; otherwise thin (docs live off-repo). |
| [wshobson/agents](https://github.com/wshobson/agents) | Catalog: 93 plugins, ~199 agents, ~185 skills; written once in Claude plugin format, adapters generate other harness formats. | Claude Code, Codex, Cursor, OpenCode, Antigravity, Copilot, Pi | **Low as workflow;** the write-once/generate-per-harness adapter is relevant only if the toolbox ever targets non-Claude agents. |
| [Task Master](https://github.com/eyaltoledano/claude-task-master) | MCP/CLI task manager that parses a PRD into dependent tasks. | Cursor, Windsurf, Roo, Claude Code and others | **Low.** Overlaps `to-tickets` + wayfinder; activity slowed (last push April 2026). |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) + [Agent Skills spec](https://agentskills.io) | `npx skills add owner/repo` cross-agent installer, and the open SKILL.md spec. | Many | **Infrastructure.** Relevant to "Package as a plugin" in `../ideas.md`: BMAD v7 and Matt Pocock already distribute this way. |

## Shortlist for deep dives (max 5)

1. **Matt Pocock skills, v1.3.2 and `main`.** The toolbox is built on it and `setup-workflow` deliberately replaces `setup-matt-pocock-skills`, so every upstream change to the tracker templates, triage labels, `GLOSSARY` naming and wayfinder rules is drift we must port by hand. The installed plugin is 1.3.1. The new in-progress skills also overlap toolbox plans directly: `retro` (improve the environment after a session) matches the "find the best workflow" goal, `chief-of-staff`'s dated, commit-cited wiki is a different answer to STATUS/HANDOFF, and `software-factory` hints at where he is taking the pipeline. Deep dive: diff v1.3.1 -> v1.3.2 -> `main` against `skills/setup-workflow` and the presets.

2. **obra's Superpowers.** The most popular methodology built the same way (auto-triggering skills in a Claude Code plugin), and the only one with a strong position on discipline: mandatory skill checks, `verification-before-completion`, TDD that deletes code written before tests, and two-stage review in `subagent-driven-development` (spec compliance, then quality). `finishing-a-development-branch` (merge/PR/keep/discard plus worktree cleanup) is a natural comparison for `/ship` and `/end-session`; `diagnosing-superpowers` (read a session transcript, explain what went wrong) is an idea we have no equivalent for. `writing-skills` includes testing skills, which bears on how this toolbox checks its own skills.

3. **Compound Engineering (Every).** Its whole thesis is that each loop should leave the next one smarter: `ce-compound` writes learnings to `docs/solutions/`, and `ce-plan` reads them. That is the gap between our per-session STATUS/HANDOFF/LOG (what happened) and durable lessons (what to do next time; today only `vault-note` in a personal vault). Its git skills (`ce-babysit-pr`, `ce-resolve-pr-feedback`) cover the part of the pipeline after `/ship`, which this toolbox leaves to Charlie, and its `config.yaml` + `docs_root` setting is a model for `workflow-settings.md`.

4. **GitHub Spec Kit.** Not to adopt its SDD flow (heavier than `lite`), but to study its customisation architecture: presets, extensions, hooks, workflow overlays, bundles, project-local overrides and an "artifact inventory" that tells you which layer supplied a file. That is a mature version of our presets x platforms x `Install-Workflow.ps1` copy model, and of the planned update flow (`workflow_version`, `-Force` re-sync). Its bug-fix (`assess -> fix -> test` with a `verified/partial/failed` verdict) and idea-assessment (`go / needs-clarification / kill`) flows are also candidates for small presets or skills.

5. **OpenSpec.** The lightest spec-driven option, aimed at brownfield work: each change is a folder (proposal, spec deltas, design, tasks) that is archived into living specs when done. That answers a question this toolbox has not settled: what happens to `.scratch/` specs and tickets after the work merges. It may suit `lite` and `fast-lane` better than full SDD, and it supports 30+ tools if a work project ever uses something other than Claude Code.

Runners-up: BMAD ("choose a planning path" as a preset-picker idea), GSD Core (if `full` is reworked), anthropics/skills `skill-creator` (evals for skills, when packaging as a plugin).

## What I might change in the workflow

- Port v1.3.2 `setup-matt-pocock-skills` fixes into `setup-workflow`, and update the installed plugin (candidate ticket).
- A "lessons" step in `/end-session` that writes durable learnings into the repo (from Compound Engineering), distinct from LOG.
- A post-`/ship` PR shepherding skill or step (from Compound Engineering / Superpowers).
- Layer and override model for presets and platforms, informed by Spec Kit, before building the update flow.
- Decide what happens to `.scratch/` specs after merge (archive into living docs, OpenSpec-style).

Link these from `../ideas.md` once the deep dives confirm them.
