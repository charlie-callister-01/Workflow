<#
.SYNOPSIS
  Opens a pull request on Azure DevOps for the current branch. Used by the /ship skill (platform: azure).
.DESCRIPTION
  Checks the branch is pushed and clean, decides the merge type from the diff:
  docs-only -> squash; anything matching -CodePattern -> normal merge (no fast-forward).
  Sets the source branch to be deleted on completion. Leaves the PR for the owner to approve and complete.
.EXAMPLE
  powershell -File tools/New-AzurePr.ps1 -Organization https://dev.azure.com/my-org -Project "My Project" -Title "docs: tidy the handoff" -BodyFile $env:TEMP\pr-body.md
#>
param(
    [Parameter(Mandatory = $true)][string]$Organization,
    [Parameter(Mandatory = $true)][string]$Project,
    [string]$Repository = '',
    [Parameter(Mandatory = $true)][string]$Title,
    [Parameter(Mandatory = $true)][string]$BodyFile,
    [string]$Target = 'main',
    # What counts as code (normal merge, explainer, review). Keep in step with code_pattern in workflow-settings.md.
    [string]$CodePattern = '^(src|tests|tools)/|^azure-pipelines\.yml$|\.(slnx|sln|props|csproj)$|^\.editorconfig$'
)
# Native tools (git, az) report through exit codes; 'Stop' would turn their stderr warnings into errors in PS 5.1.
$ErrorActionPreference = 'Continue'
if (-not $Repository) { $Repository = $Project }

function Stop-WithError([string]$message) { Write-Error $message; exit 1 }

if (-not (Get-Command az -ErrorAction SilentlyContinue)) { Stop-WithError 'Azure CLI (az) not found. Open a new PowerShell window, or install it (winget install -e --id Microsoft.AzureCLI).' }
if (-not (Test-Path -LiteralPath $BodyFile)) { Stop-WithError "Body file not found: $BodyFile" }
$bodyPath = (Resolve-Path -LiteralPath $BodyFile).Path

$branch = (git rev-parse --abbrev-ref HEAD).Trim()
if ($branch -eq $Target -or $branch -eq 'HEAD') { Stop-WithError "Refusing to open a PR from '$branch'." }
if (git status --porcelain) { Stop-WithError 'Working tree is not clean. Commit or stash first.' }

git fetch --quiet origin
if ($LASTEXITCODE -ne 0) { Stop-WithError 'git fetch failed; check the network or sign-in.' }
git ls-remote --exit-code --heads origin $branch | Out-Null
if ($LASTEXITCODE -ne 0) { Stop-WithError "Branch '$branch' is not on origin. Run: git push -u origin $branch" }
$ahead = [int](git rev-list --count "origin/$branch..HEAD")
if ($ahead -gt 0) { Stop-WithError "Branch has $ahead unpushed commit(s). Run: git push" }

$files = @(git diff --name-only "origin/$Target...HEAD")
if ($files.Count -eq 0) { Stop-WithError "No changes against origin/$Target." }
$code = @($files | Where-Object { $_ -match $CodePattern })
$squash = ($code.Count -eq 0)
if ($squash) { $kind = 'docs-only: complete with Squash' } else { $kind = "code ($($code.Count) file(s)): complete with Merge (no fast-forward)" }

$body = [IO.File]::ReadAllText($bodyPath, [Text.Encoding]::UTF8)
if ($Title -match '[^\x00-\x7F]' -or $body -match '[^\x00-\x7F]') { Write-Warning 'The title or body has non-ASCII characters; the Azure CLI may drop them. Prefer plain ASCII.' }

$squashArg = if ($squash) { 'true' } else { 'false' }
$json = az repos pr create --organization $Organization --project $Project --repository $Repository `
    --source-branch $branch --target-branch $Target --title $Title `
    --description "@$bodyPath" --squash $squashArg --delete-source-branch true --output json
if ($LASTEXITCODE -ne 0) { Stop-WithError 'az repos pr create failed (see the error above).' }

$pr = ($json -join "`n") | ConvertFrom-Json
Write-Output "PR #$($pr.pullRequestId): $($pr.repository.webUrl)/pullrequest/$($pr.pullRequestId)"
Write-Output "Merge type: $kind"
Write-Output "The source branch is deleted when the PR completes (the change itself lands in main)."
