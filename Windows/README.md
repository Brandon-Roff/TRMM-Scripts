![Windows 11 Logo](https://imgs.search.brave.com/1sP9wb_pHPu05UCX-SHcPfZ99ynhrob8zeAoLK5fka0/rs:fit:860:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy90/aHVtYi9lL2U2L1dp/bmRvd3NfMTFfbG9n/by5zdmcvNjQwcHgt/V2luZG93c18xMV9s/b2dvLnN2Zy5wbmc)

## TacticalRMM Windows Scripts Repository

## 📥 Importing Scripts into TacticalRMM Web UI

1. **Access** the TacticalRMM web interface.
2. **Navigate** to the `Scripts` section.
3. **Click** on `Import Script`.
4. **Browse** for the downloaded script file.
5. **Provide** a descriptive name and optional description.
6. **Assign** appropriate tags for easy categorization.
7. **Save** the script.
8. **Utilize** the imported script seamlessly within TacticalRMM.

## 🛠️ Scripts


### Windows 🖥️

#### PowerShell

| Script | Description |
|--------|-------------|
| Collect - Services List.ps1 | Lists all running services and their status. |
| Collect - Local Users And Groups.ps1 | Exports all local user accounts and their group memberships. |
| Security - BitLocker Status.ps1 | Checks BitLocker status on all drives. |
| Collect - Startup Programs.ps1 | Lists all startup programs (registry and Startup folder). |
| Maintain - Clear All Print Queues.ps1 | Clears all print queues on the system. |
| Apps/Install-MSI.ps1 | Installs MSI applications. |
| Apps/Software-List.ps1 | Lists installed software. |
| Checks/Check - Domain Connection.ps1 | Verifies domain connectivity. |
| Checks/Audit - Group Policy Compliance.ps1 | Audits group policy compliance. |
| Checks/Audit - Recent Software Installs.ps1 | Reports newly installed software. |
| Checks/Security - Windows Firewall Status.ps1 | Checks Windows Firewall status. |
| Checks/Check - Backup Software Presence.ps1 | Checks for backup software. |
| Checks/Check - Recent BSOD Events.ps1 | Detects recent BSOD events. |
| Checks/Check - Pending Third Party Updates.ps1 | Detects pending 3rd party updates. |
| Checks/Collect - Recently Installed Programs.ps1 | Lists recently installed applications. |
| Checks/Security - TPM BitLocker Readiness.ps1 | Checks TPM and BitLocker readiness. |
| Checks/Monitor - System Uptime.ps1 | Reports system uptime. |
| Collector Scripts/Collect - BIOS Info.ps1 | Retrieves BIOS information. |
| Collector Scripts/Collect - Domain Membership.ps1 | Collects domain membership info. |
| Collector Scripts/Check - Winget Source Status.ps1 | Checks Winget source status. |
| Collector Scripts/Audit - Defender Configuration Score.ps1 | Generates Windows Defender security score. |
| Collector Scripts/Collect - Installed Programs.ps1 | Lists all installed programs. |
| Collector Scripts/Collect - OS Build.ps1 | Fetches Windows OS build number. |
| Collector Scripts/Monitor - System Uptime.ps1 | Reports system uptime. |
| Network/Check-DuplicateIPs.ps1 | Checks for duplicate IPs. |
| Network/Disable-IPv6.ps1 | Disables IPv6 on all interfaces. |
| Network/List-NetworkAdapters.ps1 | Lists all network adapters and status. |
| Network/List-OpenPorts.ps1 | Lists all open ports. |
| Network/Show-ARP.ps1 | Displays ARP table. |
| Network/Show-DNS.ps1 | Shows DNS configuration. |
| Network/Show-FirewallStatus.ps1 | Shows Windows Firewall status. |
| Network/Show-Interfaces.ps1 | Lists active network interfaces. |
| Network/Show-Routes.ps1 | Displays routing table. |
| Network/Test-Internet.ps1 | Tests internet connectivity. |
| Quick Fixes/Maintain - Clean Print Queues And Restart Spooler.ps1 | Cleans print queues and restarts spooler. |
| Quick Fixes/Security - Disable RDP UDP Transport.ps1 | Disables RDP UDP transport. |
| TRMM Agent/Agent Version.ps1 | Outputs Tactical RMM Agent version. |
| Wazuh Agent/Wazuh Agent Version.ps1 | Outputs Wazuh Agent version. |

#### Batch

| Script | Description |
|--------|-------------|
| Collect - System Info.bat | Displays detailed system information. |
| Maintain - Flush DNS Cache.bat | Flushes the DNS cache. |
| Collect - Network Interfaces.bat | Lists all network interfaces. |
| Collect - Open Ports.bat | Lists all open ports. |
| Maintain - Clear Temp Files.bat | Deletes temp files. |
| Collect - Installed Programs.bat | Lists all installed programs. |
| Check - Disk Space.bat | Checks disk space usage. |
| Maintain - Restart Print Spooler.bat | Restarts the print spooler. |
| Security - Enable Firewall.bat | Enables Windows Firewall. |
| Security - Disable Firewall.bat | Disables Windows Firewall. |
| Check - Multi Host Ping Test.bat | Pings multiple hosts. |
| Collect - Network Drives.bat | Lists all mapped network drives. |
| Collect - Open Network Connections.bat | Lists all open network connections. |
