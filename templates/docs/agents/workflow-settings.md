# Workflow settings

Every skill in the Workflow toolbox reads this file first. Change a value here, not in the skills.
Delete a line to use the default shown in `CUSTOMISING.md`.

## Who and how

- owner: <your name>                  # who approves, who the skills wait for
- preset: full                        # full | fast-lane | lite   (see presets/)
- platform: github                    # github | azure            (see platforms/)
- workflow_version: <hash>             # Workflow repo commit this project was primed or refitted from
- workflow_repo: <path to the Workflow repo>

## Repo

- main_branch: main
- branch_prefixes: feature/, fix/, chore/, throwaway/
- commit_format: type(scope): message (phase N)
- test_command: <e.g. dotnet test MySolution.slnx | npm test>
- format_command: <e.g. dotnet format MySolution.slnx | npm run lint -- --fix>
- code_pattern: ^(src|tests|tools)/|\.(csproj|props|slnx)$|^azure-pipelines\.yml$|^\.github/   # what counts as a code change

## State files (presets full and fast-lane)

- status_file: docs/STATUS.md
- handoff_file: docs/HANDOFF.md
- log_file: docs/LOG.md
- plan_file: docs/PLAN.md
- phase_file: docs/phases/P-NN.md
- spec_folder: .scratch/pNN-<slug>/
- refactor_backlog: docs/REFACTOR.md
- explainer_dir: docs/explainers/

## Platform

- pr_command: <see platforms/github.md or platforms/azure.md>
- pr_list_command: <see platforms/...>
- azure_org: <https://dev.azure.com/your-org>        # azure only
- azure_project: <Project Name>                     # azure only
- azure_repo: <Repo Name>                           # azure only, often the project name

## Optional: Obsidian vault (day-log, vault-note, pr-explainer copy)

- vault_folder: <absolute path to the folder agents may write in>   # leave empty to switch these off
- vault_project_link: "[[Projects/My Project/My Project]]"
- vault_workspace_note: <My Project Workspace.md>                    # optional, for day-log
- vault_plan_note: <My Project Plan.md>                              # optional, for day-log
