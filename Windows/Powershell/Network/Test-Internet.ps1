$hosts = @('8.8.8.8','1.1.1.1','google.com')
foreach ($host in $hosts) {
    Write-Host "Pinging $host..."
    if (Test-Connection -ComputerName $host -Count 2 -Quiet) {
        Write-Host "$host is reachable."
    } else {
        Write-Host "$host is NOT reachable."
    }
    Write-Host
}
