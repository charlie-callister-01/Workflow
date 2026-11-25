# Opening a PR on GitHub (`gh`)

Used by `/open-pr` when `platform: github`. Needs the GitHub CLI (`winget install GitHub.cli`, then `gh auth login`).

```
git push -u origin <branch>
gh pr create --base main --head <branch> --title "<type(scope): message>" --body-file <file>
```

Before running it, `/open-pr` has already checked: not on `main`, clean tree, branch pushed, and the kind of change (code vs docs-only via `code_pattern`).

Merging (you, not the agent):

```
gh pr merge <number> --squash --delete-branch   # docs-only
gh pr merge <number> --merge  --delete-branch   # code
```

Later: a `tools/New-GhPr.ps1` (or `.sh`) wrapper that does the checks and prints the suggested merge type, like `New-AzurePr.ps1` does.
