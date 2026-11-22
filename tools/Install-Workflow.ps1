<#
.SYNOPSIS
  Copies the Workflow toolbox (skills, templates, platform file and tools) into a project. Used by /setup-workflow.
.DESCRIPTION
  Never overwrites: a file that already exists is skipped and listed, so the caller can see an existing workflow.
  Output lines start with "copied:", "skipped:" or "would copy:" (with -DryRun), then one "workflow_version:" line.
.EXAMPLE
  powershell -File tools/Install-Workflow.ps1 -Project C:\src\my-app -Preset lite -Platform github -Skills core,pr-explainer
#>
param(
    [string]$Project = '.',
    [ValidateSet('full', 'fast-lane', 'lite')][string]$Preset = 'full',
    [ValidateSet('github', 'azure')][string]$Platform = 'github',
    # 'core' = start-session, end-session, ship. Add optional skill names after it.
    [string[]]$Skills = @('core'),
    [string]$WorkflowRepo = (Split-Path -Parent $PSScriptRoot),
    [switch]$DryRun
)
$ErrorActionPreference = 'Stop'

$src = (Resolve-Path -LiteralPath $WorkflowRepo).Path
$dst = (Resolve-Path -LiteralPath $Project).Path
if ($src -eq $dst) { Write-Output 'note: priming the Workflow repo itself (skills/ is copied into .claude/skills/).' }

# PowerShell -File passes "core,pr-explainer" as one string; split it.
$Skills = @($Skills | ForEach-Object { $_ -split ',' } | ForEach-Object { $_.Trim() } | Where-Object { $_ })
$skillNames = New-Object System.Collections.Generic.List[string]
foreach ($s in $Skills) {
    if ($s -eq 'core') { 'start-session', 'end-session', 'ship' | ForEach-Object { $skillNames.Add($_) } }
    else { $skillNames.Add($s) }
}

# Pairs of (source relative to the Workflow repo, destination relative to the project).
$items = New-Object System.Collections.Generic.List[object]
function Add-Item([string]$from, [string]$to) { $items.Add(@($from, $to)) }

foreach ($name in ($skillNames | Select-Object -Unique)) {
    $dir = Join-Path $src "skills\$name"
    if (-not (Test-Path -LiteralPath $dir)) { throw "Unknown skill '$name' (no folder skills\$name)." }
    Get-ChildItem -LiteralPath $dir -Recurse -File | ForEach-Object {
        $rel = $_.FullName.Substring($dir.Length + 1)
        Add-Item "skills\$name\$rel" ".claude\skills\$name\$rel"
    }
}

Add-Item 'templates\CLAUDE.md' 'CLAUDE.md'
Get-ChildItem -LiteralPath (Join-Path $src 'templates\docs\agents') -File | ForEach-Object {
    Add-Item "templates\docs\agents\$($_.Name)" "docs\agents\$($_.Name)"
}
Add-Item "platforms\$Platform.md" 'docs\agents\platform.md'
Add-Item 'templates\docs\LOG.md' 'docs\LOG.md'
if ($Preset -ne 'lite') {
    Add-Item 'templates\docs\STATUS.md' 'docs\STATUS.md'
    Add-Item 'templates\docs\HANDOFF.md' 'docs\HANDOFF.md'
    Add-Item 'templates\docs\PLAN.md' 'docs\PLAN.md'
    Add-Item 'templates\docs\phases\P-NN.md' 'docs\phases\P-01.md'
    Add-Item 'templates\docs\adr\0000-template.md' 'docs\adr\0000-template.md'
}
if ($Platform -eq 'azure') { Add-Item 'tools\New-AzurePr.ps1' 'tools\New-AzurePr.ps1' }
if ($skillNames -contains 'pr-explainer') { Add-Item 'tools\Export-StandaloneHtml.ps1' 'tools\Export-StandaloneHtml.ps1' }

foreach ($pair in $items) {
    $from = Join-Path $src $pair[0]
    $to = Join-Path $dst $pair[1]
    if (Test-Path -LiteralPath $to) { Write-Output "skipped: $($pair[1]) (exists)"; continue }
    if ($DryRun) { Write-Output "would copy: $($pair[1])"; continue }
    $parent = Split-Path -Parent $to
    if (-not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    Copy-Item -LiteralPath $from -Destination $to
    Write-Output "copied: $($pair[1])"
}

$version = (git -C $src rev-parse --short HEAD 2>$null)
if (-not $version) { $version = 'unknown' }
Write-Output "workflow_version: $version"
