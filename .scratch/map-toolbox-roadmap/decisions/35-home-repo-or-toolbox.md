# Home repo or toolbox: the Workflow repo's role

Type: grilling
Status: resolved
Blocked by: none

## Question

What role does this repo play from v2 on: a **toolbox** that copies itself into self-contained projects (today), a **home repo** where sessions start and projects are reached by pointers (research 27), or a **hybrid**? Structural: it decides how skills reach projects and so shapes 23 (updating), 07 (repo profile), 08 (learning) and 10 (artifact organisation). The map's Notes already rule out a second repo: this is about this repo's role, not a new one.

Options:

1. **Toolbox only:** copies into projects; every project works opened alone, by anyone. Safest for team and work projects; copies drift from `workflow_version`.
2. **Full home repo:** skills live only here, sessions start here, an "Other Repos" pointer list in `AGENTS.md`. Least in each project, but projects depend on this repo, which breaks the team preset.
3. **Hybrid:** skills in one place (global install or plugin), templates and settings as per-project copies, plus a pointer list and a wiki here for cross-project work.

Points to decide:

1. **Which role**, and whether it differs by repo profile (personal vs team or work projects).
2. **Distribution** (graduated from fog): copies, global install (`~/.claude/skills`), or a plugin, and what that means for other agents (06) and for the beta track (17).
3. **Working from here** (graduated from fog "Home repo as a workplace"): an "Other Repos" pointer list, starting sessions here for cross-project work, and what a session started inside a project still needs on its own.
4. **The wiki:** whether this repo becomes an LLM-kept wiki of what I learn (`notes/index.md`, ingest / query / lint, research 29) and how it relates to the Obsidian vault (10) and the learning section (08).
5. **What lands in a project** under the chosen role (projects never carry files they don't use).

Related: 23, 06 and 10 wait on this; 27, 29, 07, 17.

## Answer

Resolved 2026-11-24 (grilling, six rounds, plus a docs check on what Claude Code loads from a sibling repo). The owner's own plan, based on [AI Hero: The Home Repo Pattern](https://www.aihero.dev/the-home-repo-pattern) (research 27). Decision 0009.

1. **Three repos, each with its own job.** This lifts the map's old "never start a second repo" rule (quoted in the Question): the owner chose separate home and knowledge repos so private work stays out of the public toolbox. This repo stays the **toolbox**: skills, templates, profiles and flows, install tools, the beta track, and research and decisions about the workflow. A separate private **home repo** is where every development session starts: pointers to sibling project repos and the knowledge repo, the owner's coding and agent practices, private scripts. A private **knowledge repo** replaces the Obsidian vault; learning is a folder inside it, and it is the LLM-kept wiki (`notes/index.md`, ingest / query / lint) research 29 suggested. This repo's `notes/` stays the toolbox's own record. Setting up home and knowledge happens outside this map.
2. **Visibility:** the toolbox stays a separate repo and **public-safe** (no employer, customer or personal details); public or private is the owner's call and a GitHub setting. Lifting outside skills doesn't need private: every source so far is MIT, and decision 0008 already allows copying a standalone skill with its notice and credit line. Unlicensed sources: rewrite the idea instead.
3. **Agent-agnostic, no plugin.** Home's `AGENTS.md` says in plain words "before working in a project, read its `AGENTS.md` first". Claude-only settings (e.g. `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD`) are avoided, an optional extra at most, and there is no plugin: teammates shouldn't have to install anything, plugins aren't universal, and a plain repo stays easier to develop.
4. **How skills arrive:** a script in home copies toolbox skills from the sibling toolbox into home's skill folder per agent (`.claude/skills/`, `.agents/skills/`, ...), the thin-adapter pattern from 01; rerun after pulling the toolbox. `/setup-workflow` and `/refit-workflow` stay global installs. **No project carries toolbox skill copies.**
5. **Personal vs shared repos.** Personal repos rely on home for general rules and skills; their `AGENTS.md` is project-only. Public, shared and work repos stand alone: they carry the team's process in neutral files (`AGENTS.md`: commands, conventions, how a change flows, definition of done; CI, lint, tests, branch protection) and none of the owner's skills, since teammates may not use this workflow. When the owner works on one from home, the owner's skills drive that process; project rules win over home's where they conflict.
6. **Layout and links:** all repos are siblings in one parent folder (`repos/home`, `repos/Workflow`, `repos/knowledge`, `repos/<project>`), never nested in home, so no agent loads home's rules as a parent folder. Pointers are relative paths. Links go one way: home points at the toolbox; the toolbox never points at home and describes "a home repo" only generically.
7. **Each instruction lives in one layer:** home = practices and pointers, project = project-only, toolbox skills = process. Nothing general is copied into personal projects' `AGENTS.md`, and the user-level `~/.claude/CLAUDE.md` stays minimal.
8. **Ideas:** `/idea` moves into home's harness and gains a knowledge-repo route alongside decision 22's project inbox and toolbox issues; details are developed in home.
9. **Hooks:** a project's hooks don't run in a session started in home (only after starting in, or `/cd` into, the project). Must-hold rules either need the session in the project or a home hook that works for every project (30).

Fact check (Claude Code docs, 2026-11-24): from an `/add-dir` folder, skills, agents and commands load; `CLAUDE.md` only with the env var above; `AGENTS.md` alone never; hooks and permissions never. Plugin skills are namespaced; committed `enabledPlugins` doesn't install anything for teammates.

Glossary: Home repo, Knowledge repo, Project harness; Toolbox now public-safe.
