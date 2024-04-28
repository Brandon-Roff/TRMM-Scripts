# Define registry paths for software information
$uninstallPath32 = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
$uninstallPath64 = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

# Function to get software information from a registry path
function Get-SoftwareInfo {
    param($path)

    # Get software information from registry
    Get-ItemProperty $path | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
}

# Get software information from both 32-bit and 64-bit registry paths
$softwareInfo32 = Get-SoftwareInfo -path $uninstallPath32
$softwareInfo64 = Get-SoftwareInfo -path $uninstallPath64

# Combine and output software information
$softwareInfo32 + $softwareInfo64 | Sort-Object DisplayName | Format-Table -AutoSize