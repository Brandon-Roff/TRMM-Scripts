Get-LocalUser | Select Name, Enabled, LastLogon | Format-Table
Get-LocalGroup | Select Name | Format-Table
Write-Host "Group Memberships:"; foreach ($g in Get-LocalGroup) {"$($g.Name):"; Get-LocalGroupMember -Group $g.Name | Select-Object Name, ObjectClass | Format-Table}