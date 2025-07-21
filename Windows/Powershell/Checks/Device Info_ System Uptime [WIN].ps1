# Get the last boot-up time
$lastBootUpTime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime

# Calculate uptime
$uptime = (Get-Date) - $lastBootUpTime

# Display uptime in days, hours, minutes, and seconds
$days = $uptime.Days
$hours = $uptime.Hours
$minutes = $uptime.Minutes

Write-Output "$days days, $hours hours, $minutes minutes"