Stop-Service -Name Spooler -Force
Get-Printer | foreach { Get-PrintJob -PrinterName $_.Name | Remove-PrintJob }
Start-Service -Name Spooler
Write-Host "Print queues cleared and spooler restarted."