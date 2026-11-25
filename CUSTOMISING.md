# Customising

Three layers, from cheapest to most work:

1. **Settings** in the project's `docs/agents/workflow-settings.md`. No skill edits.
2. **Preset and platform**: switch how much ceremony and which PR/CI home.
3. **Skills and templates**: edit or add skills here, then copy them into projects.

## 1. Settings

| Setting | Default | Used by | What it changes |
|---|---|---|---|
| `owner` | (required) | all | who approves; who the skills wait for |
| `preset` | `full` | start/end-session | which state files exist and which steps run |
| `platform` | `github` | open-pr, start/end-session | PR and CI commands, text rules |
| `workflow_version` | set by setup/refit | refit-workflow | the toolbox commit the project last took; refit shows changes since |
| `workflow_repo` | set by setup | refit-workflow | where the Workflow repo is on this machine |
| `main_branch` | `main` | all | the protected branch |
| `branch_prefixes` | `feature/ fix/ chore/ throwaway/ research/` | end-session sweep | naming and what gets tagged before delete |
| `commit_format` | `type(scope): message (phase N)` | open-pr | PR titles and commits |
| `test_command` | (required) | end-session, pr-explainer | how tests run |
| `format_command` | (optional) | AGENTS.md | formatting gate |
| `code_pattern` | `src/ tests/ tools/` + build files | open-pr, New-AzurePr.ps1 | what counts as code: explainer, review, merge type |
| `status_file` ... `explainer_dir` | `docs/...` | all | where state lives |
| `pr_command`, `pr_list_command` | per platform | open-pr, start/end-session, day-log | how PRs are opened and listed |
| `azure_org`, `azure_project`, `azure_repo` | (azure only) | New-AzurePr.ps1 | which Azure DevOps project |
| `vault_folder` | empty = off | day-log, vault-note, pr-explainer | where vault notes go |
| `vault_project_link`, `vault_workspace_note`, `vault_plan_note` | (optional) | day-log, vault-note | Obsidian links and tracker notes |

`code_pattern` lives only in `workflow-settings.md`: `New-AzurePr.ps1` reads it from there (its optional `-CodePattern` overrides it for one run).

## 2. Presets and platforms

- A **preset** is a list of which steps to keep and drop (`presets/*.md`). Mix them: `full` for the project, `fast-lane` for small changes inside it.
- A **platform** is where PRs, CI and boards live (`platforms/*.md`). Both have a draft **risk levels** table: how much process a change gets by type and risk. Developing those is on the ideas list.

## 3. Knobs inside the process

Numbers and rules you might tune per project or per person:

| Knob | Current | Where |
|---|---|---|
| Fast-lane limit | fixes under ~30 lines | AGENTS.md, presets |
| Size check | lines x ~12 tokens + ~20k; >160k suggest a fix spec, >200k make one | AGENTS.md |
| PR size | one PR per spec; split past ~400 lines | AGENTS.md |
| Implement mode | `implement` by default; `implement-spec` for 3+ independent tickets | AGENTS.md |
| File size | ~500 lines | coding standards, thermo review |
| STATUS / HANDOFF length | ~40 / ~10 lines | end-session |
| Merge type | squash for docs, normal merge for code | open-pr, platform |
| Boards mirror | phases + specs, one way, by hand | platforms/azure.md |
| Phase-end review | thermo review -> refactor backlog | end-session |

## 4. Writing a new skill

- One folder per skill in `skills/<name>/SKILL.md`, with frontmatter `name`, `description`, `tier` (core/optional), and `needs` if it depends on anything.
- Read `docs/agents/workflow-settings.md` first; refer to settings by name instead of hard-coding paths or org names.
- `disable-model-invocation: true` for skills only you should start (session and log skills).
- Keep it short: numbered steps, facts from git/the platform, never from memory.
- Log the change in `CHANGELOG.md`; if it changes how you work, add a note in `notes/decisions/`.
