# Set the path for the report file
$reportPath = "$env:TEMP\GPOReport.xml"

# Generate GPO report in XML format
Write-Output "Generating GPO report..."
Get-GPOReport -All -ReportType XML -Path $reportPath

# Load the XML report
[xml]$gpoReport = Get-Content -Path $reportPath

# Define the expected policies for compliance
$expectedPolicies = @(
    @{ Name = "PasswordPolicy"; Setting = "MinimumPasswordLength"; ExpectedValue = "8" },
    @{ Name = "AccountLockoutPolicy"; Setting = "LockoutThreshold"; ExpectedValue = "5" }
)

# Check each expected policy
$nonCompliantPolicies = @()

foreach ($policy in $expectedPolicies) {
    $gpo = $gpoReport.GPOs.GPO | Where-Object { $_.Name -eq $policy.Name }

    if ($gpo) {
        $settingValue = $gpo.Settings.Setting | Where-Object { $_.Name -eq $policy.Setting } | Select-Object -ExpandProperty Value

        if ($settingValue -ne $policy.ExpectedValue) {
            $nonCompliantPolicies += @{
                PolicyName = $policy.Name
                Setting = $policy.Setting
                ExpectedValue = $policy.ExpectedValue
                ActualValue = $settingValue
            }
        }
    }
    else {
        Write-Output "Policy $($policy.Name) not found."
    }
}

# Report compliance results
if ($nonCompliantPolicies.Count -eq 0) {
    Write-Output "All policies are compliant."
} else {
    Write-Output "Non-compliant policies found:"
    foreach ($nonCompliance in $nonCompliantPolicies) {
        Write-Output "Policy: $($nonCompliance.PolicyName)"
        Write-Output "Setting: $($nonCompliance.Setting)"
        Write-Output "Expected: $($nonCompliance.ExpectedValue), Actual: $($nonCompliance.ActualValue)"
        Write-Output ""
    }
}

# Cleanup
Remove-Item -Path $reportPath -Force
