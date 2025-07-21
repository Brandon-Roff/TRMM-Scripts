# 32-bit applications on a 64-bit system
Get-ItemProperty -Path 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' | 
Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | 
Sort-Object DisplayName

# 64-bit applications and 32-bit applications on a 32-bit system
Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' | 
Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | 
Sort-Object DisplayName