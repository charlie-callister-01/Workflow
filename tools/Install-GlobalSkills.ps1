<#
.SYNOPSIS
  Installs /setup-workflow and /refit-workflow into ~/.claude/skills so they work in any repo,
  and records where this Workflow repo is (workflow-repo.txt next to each SKILL.md).
.DESCRIPTION
  Re-run after pulling changes to the Workflow repo: it overwrites only these two skill folders.
.EXAMPLE
  powershell -File tools/Install-GlobalSkills.ps1
#>
param([string]$Target = (Join-Path $env:USERPROFILE '.claude\skills'))
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
foreach ($name in 'setup-workflow', 'refit-workflow') {
    $to = Join-Path $Target $name
    New-Item -ItemType Directory -Path $to -Force | Out-Null
    Copy-Item -Path (Join-Path $repo "skills\$name\*") -Destination $to -Recurse -Force
    [IO.File]::WriteAllText((Join-Path $to 'workflow-repo.txt'), $repo, (New-Object Text.UTF8Encoding($false)))
    Write-Output "installed: $to"
}
Write-Output "Workflow repo recorded as: $repo"
