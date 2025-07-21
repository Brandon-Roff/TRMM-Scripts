$param1 = $args[0]

$ErrorActionPreference = 'silentlycontinue'
if ($Args.Count -eq 0) {
    $TimeSpan = (Get-Date) - (New-TimeSpan -Day 1)
}
else {
    $TimeSpan = (Get-Date) - (New-TimeSpan -Day $param1)
}

if (Get-WinEvent -FilterHashtable @{LogName = 'application'; ID = '11707'; StartTime = $TimeSpan }) {
    Write-Output "Software installed"
    Get-WinEvent -FilterHashtable @{LogName = 'application'; ID = '11707'; StartTime = $TimeSpan }
    exit 1
}

{
    else 
    Write-Output "No Software install events detected in the past 24 hours."
    exit 0
}