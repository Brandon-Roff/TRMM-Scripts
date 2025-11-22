<#
.SYNOPSIS
    Package all Windows scripts into TRMM-Windows-Scripts.zip and generate release notes.
.DESCRIPTION
    - Enumerates all PowerShell and Batch scripts in Windows folder.
    - Creates a zip archive named TRMM-Windows-Scripts.zip.
    - Compares current HEAD against previous git tag to produce markdown diff notes.
    - Outputs ReleaseNotes-Windows.md in release folder.
.PARAMETER PreviousTag
    Optional git tag to diff against. If omitted, auto-selects the most recent tag before HEAD.
.PARAMETER OutputDir
    Optional output directory. Defaults to ./release.
.EXAMPLE
    ./Create-Windows-Release.ps1 -PreviousTag v1.2.0
.NOTES
    Requires git and PowerShell 5+. Use from repo root.
#>
[CmdletBinding()]
param(
    [string]$PreviousTag,
    [string]$OutputDir = (Join-Path (Get-Location) 'release')
)

function Get-PreviousTag {
    param([string]$Explicit)
    if ($Explicit) { return $Explicit }
    $tags = git tag --sort=-creatordate | Where-Object { $_ }
    if (-not $tags) { return $null }
    return $tags | Select-Object -Skip 0 -First 1
}

if (-not (Test-Path $OutputDir)) { New-Item -ItemType Directory -Path $OutputDir | Out-Null }
$archiveName = 'TRMM-Windows-Scripts.zip'
$archivePath = Join-Path $OutputDir $archiveName
if (Test-Path $archivePath) { Remove-Item $archivePath -Force }

$windowsRoot = Join-Path (Get-Location) 'Windows'
if (-not (Test-Path $windowsRoot)) { Write-Error "Windows folder not found."; exit 1 }

$scriptFiles = Get-ChildItem $windowsRoot -Recurse -Include *.ps1,*.bat | Where-Object { -not $_.PSIsContainer }
if (-not $scriptFiles) { Write-Warning "No Windows scripts found" }
Compress-Archive -Path $scriptFiles.FullName -DestinationPath $archivePath
Write-Host "Created archive: $archivePath"

$tag = Get-PreviousTag -Explicit $PreviousTag
$releaseNotesPath = Join-Path $OutputDir 'ReleaseNotes-Windows.md'

$md = @()
$md += "# Windows Scripts Release"
$md += "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$md += "Archive: $archiveName"
$md += "Previous Tag: $tag"
$md += ""

if ($tag) {
    $diffFiles = git diff --name-status $tag HEAD | Where-Object { $_ -match '^([AMRDC])\s+Windows/' }
    $md += "## Changes Since $tag"
    if ($diffFiles) {
        $md += "| Status | File |"
        $md += "|--------|------|"
        foreach ($line in $diffFiles) {
            $parts = $line -split "\s+"; $status=$parts[0]; $file=$parts[1]
            if ($status -eq 'R') { $file=$parts[2] }
            $md += "| $status | $file |"
        }
    } else {
        $md += "No file changes in Windows folder since $tag."
    }
} else {
    $md += "No previous tag found; initial release notes."
}

$categorySummary = $scriptFiles | Group-Object { $_.Directory.Name } | Sort-Object Count -Descending
$md += ""
$md += "## Category Summary"
$md += "| Folder | Script Count |"
$md += "|--------|--------------|"
foreach ($c in $categorySummary) { $md += "| $($c.Name) | $($c.Count) |" }

$md += ""
$md += "## Included Scripts"
$md += "| Name | Relative Path | Size (KB) |"
$md += "|------|---------------|-----------|"
foreach ($f in $scriptFiles) {
    $rel = $f.FullName.Replace((Get-Location).Path + '\\','')
    $sizeKB = [math]::Round($f.Length / 1KB,2)
    $md += "| $($f.Name) | $rel | $sizeKB |"
}

$md -join "`n" | Set-Content -Path $releaseNotesPath -Encoding UTF8
Write-Host "Release notes generated: $releaseNotesPath"
Write-Host "Done."
exit 0