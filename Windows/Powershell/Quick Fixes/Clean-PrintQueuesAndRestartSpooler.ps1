# Stop the Print Spooler service
Stop-Service -Name Spooler -Force

# Clear all print jobs in all print queues
Get-Printer | foreach { Get-PrintJob -PrinterName $_.Name | Remove-PrintJob }

# Start the Print Spooler service
Start-Service -Name Spooler