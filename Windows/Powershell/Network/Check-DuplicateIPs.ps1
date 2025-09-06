$localIPs = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.IPAddress -ne '127.0.0.1'}).IPAddress
foreach ($ip in $localIPs) {
    $arp = arp -a | Select-String $ip
    if ($arp) {
        Write-Host "Duplicate IP detected: $ip"
    }
}
