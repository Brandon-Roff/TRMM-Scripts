# Check and display the domain of the current Windows computer
$domain = (Get-WmiObject Win32_ComputerSystem).Domain

if ($domain -ne $null -and $domain -ne $env:COMPUTERNAME) {
    Write-Output "$domain"
} else {
    Write-Output "This computer is not joined to a domain."
}