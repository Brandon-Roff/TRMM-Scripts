Get-LocalUser | ForEach-Object {
    $user = $_.Name
    $groups = (Get-LocalGroup | Where-Object { (Get-LocalGroupMember $_.Name -ErrorAction SilentlyContinue | Where-Object Name -eq $user) }).Name -join ', '
    [PSCustomObject]@{User=$user; Groups=$groups}
} | Format-Table -AutoSize
