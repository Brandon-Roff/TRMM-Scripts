# Check if RDP UDP transport is enabled
$rdpUdpEnabled = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "EnableUDPPort"

if ($rdpUdpEnabled -and $rdpUdpEnabled.EnableUDPPort -eq 1) {
    # Disable RDP UDP transport
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "EnableUDPPort" -Value 0
    Write-Output "RDP UDP transport has been disabled."
} elseif (-not $rdpUdpEnabled) {
    # If the registry value does not exist, create it and disable UDP transport
    New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "EnableUDPPort" -Value 0 -PropertyType DWORD -Force
    Write-Output "RDP UDP transport has been disabled."
} else {
    Write-Output "RDP UDP transport is already disabled."
}