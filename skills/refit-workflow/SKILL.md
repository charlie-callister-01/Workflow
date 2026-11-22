---
name: refit-workflow
description: Merge the Workflow toolbox into a repo that already has its own workflow, without bloat: analyse what exists against the toolbox, write a targeted grill brief for /mattpocock-skills:grill-with-docs, then apply the decisions. Also used to update a primed repo when the toolbox has changed.
disable-model-invocation: true
tier: global
needs: installed with tools/Install-GlobalSkills.ps1 (writes workflow-repo.txt next to this file)
---

The Workflow repo path (W) is in `workflow-repo.txt` next to this SKILL.md (or `workflow_repo` in the project's `docs/agents/workflow-settings.md`). Work folder: `.scratch/workflow-refit/`.

**Part 1: analyse and brief** (run until step 4, then stop).

1. **Since when?** If `docs/agents/workflow-settings.md` has `workflow_version`, list toolbox changes since then: `git -C W log --oneline <version>..HEAD` and the matching `W\CHANGELOG.md` lines.
2. **Analyse** with one subagent (wide read; only its table comes back). Brief it to compare the repo's CLAUDE.md/AGENTS.md rules, `.claude/skills/*`, `docs/` state files, `docs/agents/*`, CI and PR scripts against `W\skills\`, `W\templates\`, `W\presets\<preset>.md` and `W\platforms\<platform>.md`, and return one row per item: `item | repo version (path:lines) | toolbox version (path) | label | one-line note`. Labels: **same**, **duplicate** (overlap; merge), **conflicting** (disagree; pick one), **missing** (toolbox has it, repo does not), **repo-only** (project-specific; keep). `docs/agents/*` written by `setup-matt-pocock-skills` count as same or duplicate, never missing. Write it to `.scratch/workflow-refit/analysis.md`.
3. **Grill brief:** write `.scratch/workflow-refit/grill-brief.md`:
   - **Goal:** adopt the toolbox where it helps, with no bloat: every addition replaces something or is needed; CLAUDE.md stays under ~120 lines; one source per rule.
   - **Decide only these rows:** each duplicate, conflicting and missing row, numbered, with both versions quoted (a few lines each) and your recommended outcome.
   - **Allowed outcomes per row:** refit (merge into one), replace (toolbox wins), trim (delete the duplicate), add, leave (repo wins).
   - **Out of scope:** same and repo-only rows; product code.
   - **ADRs:** only for choices that are hard to reverse, surprising, and a real trade-off.
   - **Output:** a decisions table at the bottom of this file (`row | outcome | note`).
4. **Hand over.** Print the row counts per label and this exact line for the owner to type:
   `/mattpocock-skills:grill-with-docs Refit the workflow: work through .scratch/workflow-refit/grill-brief.md row by row and record each outcome in its decisions table.`
   Stop here.

**Part 2: apply** (run `/refit-workflow` again once the decisions table is filled).

5. **Branch** `chore/workflow-refit`. Apply each decision group as one commit (`chore(workflow): <group>`): copy missing items with `W\tools\Install-Workflow.ps1` (it never overwrites), merge or trim the rest by hand. Set `workflow_version` to `git -C W rev-parse --short HEAD`.
6. **No-bloat check:** CLAUDE.md under ~120 lines; no rule stated in two places; no skill duplicated under two names. Report the line counts before and after.
7. Show the diff summary, then offer `/ship`. Do not push without a yes. Move `.scratch/workflow-refit/` to `.scratch/archive/` after the PR is merged.
