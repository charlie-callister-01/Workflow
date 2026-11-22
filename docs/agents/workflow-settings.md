# Workflow settings

Every skill in the Workflow toolbox reads this file first. Change a value here, not in the skills.
This repo is the toolbox itself, primed with its own workflow (preset `lite`).

## Who and how

- owner: Charlie
- preset: lite
- platform: github
- workflow_version: 4935f51
- workflow_repo: . (this repo)

## Repo

- main_branch: main
- branch_prefixes: feature/, fix/, chore/, throwaway/, research/
- commit_format: type(scope): message
- test_command: none (smoke test: `powershell -File tools/Install-Workflow.ps1 -Project <empty temp folder> -Preset full -Platform azure -Skills core,pr-explainer -DryRun`)
- format_command: none
- code_pattern: ^(skills|tools|templates)/

## State files (preset lite)

- log_file: docs/LOG.md

## Platform

- pr_command: `gh pr create --base main --title "<title>" --body-file <file>`
- pr_list_command: `gh pr list --state open --json number,title,headRefName --jq '.[] | [.number,.title,.headRefName] | @tsv'`

## Optional: Obsidian vault

- vault_folder:     # empty = day-log, vault-note and the explainer copy are off
