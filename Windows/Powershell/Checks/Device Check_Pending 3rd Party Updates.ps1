# Default values
$outdatedCount = 0
$tool = "Unknown"

# Winget
if (Get-Command winget -ErrorAction SilentlyContinue) {
    $updates = winget upgrade --accept-source-agreements --accept-package-agreements | Select-String "^\S"
    $outdatedCount = ($updates | Select-Object -Skip 1).Count
    $tool = "Winget"
}

# Chocolatey fallback
elseif (Get-Command choco -ErrorAction SilentlyContinue) {
    $updates = choco outdated --no-color | Select-String "^\S" | Where-Object { $_ -notmatch "^Chocolatey|" }
    $outdatedCount = ($updates | Select-Object -Skip 1).Count
    $tool = "Chocolatey"
}

# Output a clean, pretty message
if ($outdatedCount -gt 0) {
    Write-Host "$outdatedCount third-party software update(s) available via $tool."
} elseif ($tool -ne "Unknown") {
    Write-Host "All third-party software is up-to-date via $tool."
} else {
    Write-Host "No package manager (Winget or Chocolatey) detected on this system."
}
