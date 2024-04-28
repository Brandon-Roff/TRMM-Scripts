function Get-TacticalRMMVersion {
    # Path to the Tactical RMM agent executable
    $agentPath = "C:\Program Files\tacticalagent\tacticalrmm.exe"
    
    # Check if the agent executable exists
    if (Test-Path $agentPath) {
        # Get the version information of the agent executable
        $versionInfo = Get-Item $agentPath | Select-Object -ExpandProperty VersionInfo
        $version = $versionInfo.FileVersion

        # Output the version
        Write-Output "$version"
    } else {
        Write-Output "N/A"
    }
}

# Call the function to get the version
Get-TacticalRMMVersion