# Multi-agent projects

Type: grilling
Status: resolved
Blocked by: 01, 02, 35

## Question

When a project uses one or several agents (Claude Code, Cursor, Codex, Copilot), how do the toolbox's skills, instruction files (CLAUDE.md / AGENTS.md / rules) and install scripts work? How far does the toolbox go: open formats only, or install support per agent? And the **agent refit**: how an existing Claude-only project is moved to work with other agents or several at once (choosing the agents at setup or refit). A new skill (`/refit-agents`) or a mode of `/refit-workflow`?

## Settled so far

- 2026-11-22: the instruction file is `AGENTS.md`, with `CLAUDE.md` as the single line `@AGENTS.md` (decision 0006, on trial in `notes/trials.md` with Antigravity CLI). Still open: skills for other agents (Antigravity loads `.agents/skills/`), per-agent adapters, and `/refit-agents` vs a refit mode. The trial's verdict section feeds this ticket.

## From 05 (2026-11-23)

`/interrogate` (trial 3 in 05) could run as Claude plus Codex once this ticket settles how several agents work in one project.

## From 35 (2026-11-24)

Reframed by 35: projects carry no toolbox skills, so per-agent skill adapters are built once, by home's copy script (`.claude/skills/`, `.agents/skills/`, ...), not per project. What is left per project is the instruction file (`AGENTS.md` plus thin shims such as `CLAUDE.md`), and for shared repos only neutral process files. The "agent refit" shrinks to adding shims; `/refit-agents` may not be needed. Still open: several agents in one project or one session, and which agents home's script supports.

## Answer

Resolved 2026-11-24 (grilling, three rounds, plus two research passes and a live junction test). Facts: [notes/research/2026-11-24 Agents, instruction files and skill folders.md](../../../notes/research/2026-11-24%20Agents,%20instruction%20files%20and%20skill%20folders.md). Revises decision 0006 (note added there); no new decision record.

1. **Scope:** open formats are the core: `AGENTS.md` and Agent Skills `SKILL.md`. Per-agent work is only skill folders and settings in home; features one agent alone has (Claude Code hooks, `model:` frontmatter) are optional extras no skill depends on.
2. **Skill bodies are agent-neutral:** plain words ("ask the owner", "start a subagent if your agent has them, otherwise do it inline"), never a vendor's tool names. Claude-only frontmatter keys may stay (CLI agents are expected to ignore unknown keys; confirm by trial). Lint is 09's; fixing today's skills is roadmap work.
3. **Several agents** hand off only through repo files (spec, tickets, PR, LOG); any agent can pick up where another stopped; parallel work on one repo uses worktrees (36). One agent calling another for a second opinion (`codex exec`, 05's `/interrogate`) is a trial candidate, not a rule.
4. **Projects carry `AGENTS.md` only.** Every agent checked reads it (Claude Code since v2.1.277 when there is no `CLAUDE.md`; Gemini CLI after one user setting). No `CLAUDE.md` shim: one exists only for a Claude-only need and then starts with `@AGENTS.md`. This also stops Matt's setup skill writing into `CLAUDE.md`. Removing old bare shims joins 23's migration.
5. **Agent setup lives in home**, per agent and at user level where the agent allows (Gemini's `context.fileName`, permission allow-lists, Claude settings). A project's `agents:` line in `workflow-settings.md` records only which agents it expects; `/setup-workflow`, `/refit-workflow` and `Install-Workflow.ps1 -Agents` read it. No `/refit-agents`. An agent-specific file goes in a project only for a shared repo's team need (a teammate's agent with no home).
6. **Skill folders in home:** one real copy in `.agents/skills` (Codex, Cursor, Copilot CLI, Gemini CLI, Antigravity), and `.claude/skills` as a directory junction to it for Claude Code. Tested 2026-11-24: Claude Code and Copilot CLI read through the junction and list each skill once. Rules: `.claude/skills` is gitignored (git sees a junction as a second copy), the copy script recreates the junction on every run (git-for-windows bugs can delete or follow junctions), and if an agent won't follow it, the script copies into that folder instead. Still to check: invoking a junctioned skill in a real Claude session; whether Cursor lists skills twice.
7. **Matt Pocock's skills** reach every agent through home's copy script, from a clone of `mattpocock/skills` pinned to a commit in `notes/upstream.md` (moved at the monthly upstream sync, 05), into the same folders as ours. No plugin (35); one version for all agents. Toolbox skills call his by bare name (`/grilling`, not `/mattpocock-skills:grilling`); `/setup-workflow` keeps replacing his setup skill (11).
8. **Permissions:** home keeps a permission starter per agent (Claude's is today's allow-list; Antigravity's is written on its next trial, after it asked too often and stalled). The toolbox's setup guide says to give each agent one. Must-hold blocks are 30's.
9. **The decision 0006 trial:** the owner's first Antigravity impressions are in the research note; the full write-up stays open in `notes/trials.md`.
