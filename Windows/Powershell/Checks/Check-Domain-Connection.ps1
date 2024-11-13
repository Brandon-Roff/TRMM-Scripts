# Fetch the AD domain to check
$domain = (Get-WmiObject Win32_ComputerSystem).Domain

# Check if the domain is accessible
function Test-ADDomainAccess {
    param (
        [string]$domain
    )
    
    try {
        # Attempt to discover and get a Domain Controller in the specified domain
        $domainController = (Get-ADDomainController -domain $domain -Discover -ErrorAction Stop).Name
        Write-Output ""
        Write-Output "AD Domain $domain is accessible." 
        Write-Output "Domain Controller: $domainController"
        Write-Output ""
    }
    catch {
        Write-Output "Failed to access AD Domain $domain"
        Write-Output "Error: $($_.Exception.Message)"
    }
}

# Import Active Directory module
if (!(Get-Module -ListAvailable -Name ActiveDirectory)) {
    Import-Module ActiveDirectory
}

# Run the domain accessibility test
Test-ADDomainAccess -domain $domain