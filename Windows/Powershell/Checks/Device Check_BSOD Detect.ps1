<#
.SYNOPSIS
    Checks for BSOD (BugCheck) events in the last 14 days.
#>

$days = 14
$cutoff = (Get-Date).AddDays(-$days)

$bsodEvents = Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    Id      = 1001
    StartTime = $cutoff
} -ErrorAction SilentlyContinue | Where-Object {
    $_.Message -like "*bugcheck*"
}

if ($bsodEvents.Count -gt 0) {
    $latest = $bsodEvents[0].Message -match "BugcheckCode: (\d+)" | Out-Null
    $code = $matches[1]
    Write-Host "$($bsodEvents.Count) BSOD(s) detected in the last $days days"
    Write-Host "Latest BugCheck Code: 0x{0:X}" -f [int]$code
} else {
    Write-Host "No BSODs detected in the last $days days"
}