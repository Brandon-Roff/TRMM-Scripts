Get-NetIPAddress | Where-Object {$_.AddressState -eq 'Preferred'} | Select-Object InterfaceAlias,IPAddress
