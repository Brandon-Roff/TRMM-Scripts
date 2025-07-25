<#
.SYNOPSIS
    Detects user-installed software added in the last 7 days.
    Scans both 32-bit and 64-bit registry uninstall keys.
#>

$days = 7
$cutoffDate = (Get-Date).AddDays(-$days)
$now = Get-Date

$uninstallKeys = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

$recentApps = foreach ($keyPath in $uninstallKeys) {
    Get-ItemProperty -Path $keyPath -ErrorAction SilentlyContinue | ForEach-Object {
        $name = $_.DisplayName
        $publisher = $_.Publisher
        $installDateRaw = $_.InstallDate

        if ($installDateRaw -match '^\d{8}$') {
            $installDate = [datetime]::ParseExact($installDateRaw, "yyyyMMdd", $null)
        } elseif ($_.PSObject.Properties.Name -contains 'InstallDate' -and $_.InstallDate -is [datetime]) {
            $installDate = $_.InstallDate
        } else {
            $installDate = $null
        }

        if ($name -and $installDate -and $installDate -ge $cutoffDate -and $installDate -le $now) {
            [PSCustomObject]@{
                Name        = $name
                Publisher   = $publisher
                InstallDate = $installDate.ToString("yyyy-MM-dd")
            }
        }
    }
}

if ($recentApps.Count -gt 0) {
    Write-Host ""
    Write-Host "Recently Installed Applications (last $days days):`n"
    $recentApps | Sort-Object InstallDate -Descending | Format-Table -AutoSize
} else {
    Write-Host "No software installed in the last $days days."
}
