<#
.SYNOPSIS
  Turns an Artifact page source (a fragment: <title>, <style>, content, no <html>/<head>) into a
  standalone HTML document that opens correctly in any browser, outside Claude.

.DESCRIPTION
  The Artifact tool wraps a page in a doctype, charset and viewport at publish time, so the source
  files in docs/explainers/ are fragments. Opened straight from disk they render in quirks mode and
  without a declared charset, which garbles characters such as arrows and middle dots.
  This script writes a full document: <!doctype html>, <html lang="en-GB">, a <head> with charset,
  viewport and the page's <title>, the publish-time reset, and the fragment in <body>.
  If the fragment uses Mermaid (class="mermaid"), it adds the Mermaid script (needs internet).
  A file that already starts with a doctype is copied unchanged.

.EXAMPLE
  # One file, to a new path
  ./tools/Export-StandaloneHtml.ps1 -Source docs/explainers/x.html -Destination "<vault>/Artifacts/PR Explainers/2026-11-19 x.html"

.EXAMPLE
  # Fix every vault copy in place
  Get-ChildItem "<vault>/Artifacts" -Recurse -Filter *.html | ForEach-Object {
    ./tools/Export-StandaloneHtml.ps1 -Source $_.FullName -Destination $_.FullName }
#>
param(
  [Parameter(Mandatory)] [string] $Source,
  [Parameter(Mandatory)] [string] $Destination
)

$utf8 = New-Object System.Text.UTF8Encoding($false)
$text = [IO.File]::ReadAllText((Resolve-Path $Source), $utf8)

if ($text.TrimStart() -match '^(?i)<!doctype') {
  if ((Resolve-Path $Source).Path -ne [IO.Path]::GetFullPath($Destination)) {
    [IO.File]::WriteAllText($Destination, $text, $utf8)
  }
  Write-Output "already standalone: $Destination"
  return
}

$title = 'Explainer'
$m = [regex]::Match($text, '(?is)<title>(.*?)</title>')
if ($m.Success) { $title = $m.Groups[1].Value.Trim() }

$mermaid = ''
if ($text -match 'class="mermaid"') {
  $mermaid = @'
<script src="https://cdn.jsdelivr.net/npm/mermaid@10.9.1/dist/mermaid.min.js"></script>
<script>mermaid.initialize({ startOnLoad: true });</script>
'@
}

$doc = @"
<!doctype html>
<html lang="en-GB">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>$title</title>
<style>
:root { color-scheme: light; padding-top: env(safe-area-inset-top, 0px); padding-bottom: env(safe-area-inset-bottom, 0px); }
body { margin: 0; font: 14px system-ui, -apple-system, "Segoe UI", Arial, sans-serif; }
img { max-width: 100%; }
[hidden] { display: none !important; }
</style>
</head>
<body>
$text
$mermaid
</body>
</html>
"@

[IO.File]::WriteAllText($Destination, $doc, $utf8)
Write-Output "standalone: $Destination"
