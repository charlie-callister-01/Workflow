---
name: setup-workflow
description: "[wf] Prime the current repo to work with the Workflow toolbox: detect the stack, ask preset/platform/skills in one round, copy skills and templates without overwriting, fill in the settings and AGENTS.md on a chore/workflow-setup branch. Offers /refit-workflow if the repo already has a workflow."
disable-model-invocation: true
tier: global
needs: installed with tools/Install-GlobalSkills.ps1 (writes workflow-repo.txt next to this file)
---

The Workflow repo path (W) is in `workflow-repo.txt` next to this SKILL.md. If it is missing, ask for the path once.
This skill replaces `/mattpocock-skills:setup-matt-pocock-skills`: the templates write the same `docs/agents/*` files his skills read. Do not run both.
The project's instructions live in `AGENTS.md`. `CLAUDE.md` is the single line `@AGENTS.md` (Claude Code imports it; other agents read `AGENTS.md` directly). Decision 0006.

1. **Explore** (read only, a few commands; no subagent needed):
   - `git status -sb`, `git remote -v`, default branch (`git symbolic-ref refs/remotes/origin/HEAD`, else `main`). Stop if the tree is dirty.
   - Stack and commands: `*.sln*`/`*.csproj` -> `dotnet test` / `dotnet format`; `package.json` scripts -> `npm test` / lint; `pyproject.toml` -> `pytest` / `ruff`; etc. Source folders for `code_pattern`.
   - CI: `azure-pipelines.yml` or `.github/workflows/`. Platform guess: Azure remote or pipeline -> `azure`; else `github`.
   - Existing workflow: `CLAUDE.md`/`AGENTS.md`, `.claude/skills/*`, `docs/STATUS.md`, `docs/agents/*`, `.scratch/`, PR scripts. Note what exists.
2. **Ask in one round**, each with the detected or recommended answer filled in so "yes" accepts all: preset (`full` / `fast-lane` / `lite`, see `W\presets\`), platform (`github` / `azure`), optional skills (`pr-explainer`, `thermo-nuclear-code-quality-review`, `day-log`, `vault-note`), owner name, vault folder (blank = off), Azure org/project/repo (azure only), test and format commands, `code_pattern`. Wait for the answers.
3. **Branch:** `git checkout -b chore/workflow-setup`.
4. **Copy:** `powershell -File "W\tools\Install-Workflow.ps1" -Project . -Preset <p> -Platform <pl> -Skills core,<optional...>`. It never overwrites; keep its `skipped:` list and the `workflow_version:` line.
5. **Fill in** (only files the script copied this run; never rewrite a skipped file):
   - `docs/agents/workflow-settings.md`: every answer from step 2, the platform's `pr_command`/`pr_list_command` from `docs/agents/platform.md`, and `workflow_version: <hash>` and `workflow_repo: W` under "Who and how". Delete the lines that do not apply to the preset and platform (e.g. `lite` keeps only `log_file` under state files; `github` drops the `azure_*` lines; no vault drops the vault lines except an empty `vault_folder:`).
   - `AGENTS.md`: replace the `<...>` placeholders from what you explored; delete lines that do not apply to the preset. Keep it under ~120 lines. Leave `CLAUDE.md` as the single line `@AGENTS.md`.
   - Preset `full`/`fast-lane`: a first `docs/STATUS.md` (today, "workflow set up", next action) and `docs/HANDOFF.md`; `docs/LOG.md` first line.
   - If `AGENTS.md` was **skipped because `CLAUDE.md` exists**: edit neither file; step 7 offers `/refit-workflow`, which moves `CLAUDE.md` to `AGENTS.md`.
   - If `AGENTS.md` was **skipped because it existed**: do not edit it; propose a short `## Workflow` section (pointer to `docs/agents/workflow-settings.md`, the pipeline line for the preset, `/open-pr` as the only PR route) and add it only after a yes. If `CLAUDE.md` existed too, step 7 offers `/refit-workflow` to make it the `@AGENTS.md` pointer.
6. **Show** `git status` and the diff summary; commit after a yes: `chore: set up the workflow (<preset>, <platform>)`. Offer `/open-pr`; do not push without a yes.
7. **Existing workflow?** If step 1 found one, or step 4 skipped `AGENTS.md` because `CLAUDE.md` exists, or skipped anything beyond `AGENTS.md`, report what was skipped in one short list and offer `/refit-workflow` to merge the two without bloat.
8. **Plugin check** once: if no `mattpocock-skills:*` skills are in your skill list, print these lines for the owner to type (only the user can install plugins), then restart Claude Code:
   `/plugin install mattpocock-skills@claude-plugins-official`
   If that marketplace is missing: `/plugin marketplace add mattpocock/skills`, then `/plugin install mattpocock-skills@mattpocock`.
   Do not run `setup-matt-pocock-skills` here.
9. **What to build (preset `full` only, new projects).** Ask: "Is the way from idea to a plan clear?" (exploring, `W\notes\decisions\0005-wayfinder-for-foggy-starts.md`).
   - **No, it is foggy:** print this line for the owner to type (wayfinder can only be started by the user):
     `/mattpocock-skills:wayfinder Destination: docs/PLAN.md with phases, Phase 1 sliced into a Specs list in docs/phases/P-01.md, and the first ADRs and GLOSSARY terms. Idea: <one line from the owner>`
   - **Yes:** print `/mattpocock-skills:grill-with-docs Write docs/PLAN.md and slice Phase 1 into a Specs list. Idea: <one line>`.
