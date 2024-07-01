# Get system uptime
$uptime = (Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime
Write-Output "System Uptime: $($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes"
