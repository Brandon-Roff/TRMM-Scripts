# Initialize the total score and points per check
$totalScore = 100
$pointsPerCheck = $totalScore / 5
$securityScore = 0

# Function to check if a Defender feature is enabled
function Check-DefenderStatus {
    param (
        [string]$FeatureName,
        [scriptblock]$CheckFunction
    )
    try {
        if (& $CheckFunction) {
            Write-Output "$FeatureName is enabled."
            return $true
        } else {
            Write-Output "$FeatureName is disabled."
            return $false
        }
    } catch {
        Write-Output "$FeatureName status could not be determined."
        return $false
    }
}

# Check if Real-time Protection is enabled
if (Check-DefenderStatus -FeatureName "Real-time Protection" -CheckFunction { (Get-MpPreference).DisableRealtimeMonitoring -eq $false }) {
    $securityScore += $pointsPerCheck
}

# Check if Behavior Monitoring is enabled
if (Check-DefenderStatus -FeatureName "Behavior Monitoring" -CheckFunction { (Get-MpPreference).DisableBehaviorMonitoring -eq $false }) {
    $securityScore += $pointsPerCheck
}

# Check if Cloud-based Protection is enabled
if (Check-DefenderStatus -FeatureName "Cloud-based Protection" -CheckFunction { (Get-MpPreference).MAPSReporting -ne 0 }) {
    $securityScore += $pointsPerCheck
}

# Check if Automatic Sample Submission is enabled
if (Check-DefenderStatus -FeatureName "Automatic Sample Submission" -CheckFunction { (Get-MpPreference).SubmitSamplesConsent -ne 0 }) {
    $securityScore += $pointsPerCheck
}

# Check if Antivirus Signatures are up-to-date
if (Check-DefenderStatus -FeatureName "Antivirus Signatures" -CheckFunction { (Get-MpComputerStatus).AMServiceEnabled -and (Get-MpComputerStatus).AntivirusEnabled }) {
    $securityScore += $pointsPerCheck
}

# Display the final security percentage
Write-Output "`nWindows Defender Security Score: $securityScore%"