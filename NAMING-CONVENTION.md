# Naming Convention

This repository standardizes script filenames with a leading category prefix followed by a concise title:

`<Category> - <Descriptive Title>.<ext>`

Extensions preserved (`.sh`, `.ps1`, `.bat`). Spaces are used for readability. Underscores have been removed. Categories:

| Category Prefix | Purpose |
|-----------------|---------|
| Check - | One-off status / health verification tests (latency, reachable, service active) |
| Monitor - | Ongoing or trend/resource metrics (CPU/RAM/load/bandwidth/IO/uptime trend) |
| Audit - | Security / configuration enumeration & integrity (users, ports, cron diff) |
| Collect - | Inventory & general data gathering (BIOS info, system info, domain, installed programs) |
| Software Management - | Install/update/package state and repo health |
| Security - | Explicit security enforcement or provisioning (firewall setup) |
| Network - | Network diagnostics & configuration (interfaces, routes, DNS, connectivity) |
| Agent - | Management/monitoring agent status, install, update (Mesh, Wazuh, TRMM, Patchmon, Remotely) |
| Maintain - | Cleanup & maintenance (disk clean, kernel prune, temp files, spooler) |
| Customize - | System personalization (bashrc modifications) |
| Cron - | Crontab entry presence & scheduling checks |
| Image - | Container image hygiene (staleness, dangling) |

Exit codes: 0 = OK, 1 = alert/failure, 2 = secondary state (e.g., auto-recovered) where applicable.

Future additions should choose the most specific category; if ambiguous prefer `Collect -` for pure inventory and `Audit -` for security-relevant listings.

## Recent Rename Batch (Monitoring)

| Old Name | New Name |
|----------|----------|
| CPU_Usage.sh | Monitor - CPU Usage.sh |
| RAM_Usage.sh | Monitor - RAM Usage.sh |
| Disk IO Activity.sh | Monitor - Disk IO Activity.sh |
| Process Monitor.sh | Monitor - Process Snapshot.sh |
| network-bandwidth-monitor.sh | Monitor - Network Bandwidth.sh |
| uptime-trend.sh | Monitor - Uptime Trend.sh |
| dns-resolution-latency.sh | Check - DNS Resolution Latency.sh |
| journald-error-rate.sh | Monitor - Journald Error Rate.sh |
| orphan-process-check.sh | Check - Orphan Zombie Processes.sh |
| cron-integrity-monitor.sh | Audit - Cron Integrity.sh |
| docker-container-health-summary.sh | Monitor - Docker Container Health.sh |
| image-staleness-report.sh | Image - Stale Images Report.sh |
| Check - MeshAgent_is_running.sh | Agent - MeshAgent Status.sh |
| Check - Remotely_is_running.sh | Agent - Remotely Status.sh |
| Check - Wazuh_is_running.sh | Agent - Wazuh Status.sh |
| Check - Patchmon Agent is installed.sh | Agent - Patchmon Status.sh |
| Check - DiskSpace.sh | Check - Disk Space.sh |
| Check - SwapSpace.sh | Monitor - Swap Usage.sh |

The original files have been renamed; README tables updated accordingly.

## Subsequent Rename Batches

### Collector Tasks
| Old Name | New Name |
|----------|----------|
| Check Docker is Running.sh | Check - Docker Service.sh |
| ClamAV Check.sh | Agent - ClamAV Status.sh |
| Nala Install Status.sh | Software Management - Nala Install Status.sh |
| SSH Port Fetch.sh | Collect - SSH Port.sh |
| SSH Root Access.sh | Security - SSH Root Access.sh |
| UFW Status.sh | Security - UFW Status.sh |
| Unattended Upgrades.sh | Software Management - Unattended Upgrades Status.sh |

### Network
| Old Name | New Name |
|----------|----------|
| disable-ipv6.sh | Network - Disable IPv6.sh |
| show-dns.sh | Network - Show DNS.sh |
| test-internet.sh | Check - Internet Connectivity.sh |
| check-duplicate-ips.sh | Check - Duplicate IPs.sh |
| firewall-status.sh | Security - Firewall Status.sh |

### Security / Audit / Access / UFW
| Old Name | New Name |
|----------|----------|
| Basic Audit.bash | Audit - Basic System.sh |
| Security_ Docker Audit [LIN].sh | Audit - Docker Exposure.sh |
| Security_ Port Audit [LIN].sh | Audit - Open Ports Diff.sh |
| Audit Users with sudo.sh | Audit - Sudo Users.sh |
| Security_ Audit Users [LIN].sh | Audit - Users Overview.sh |
| UFW_ Install and Prevision firewall.sh | Security - UFW Provision.sh |

### Maintenance (previously 'Maintence' folder typo)
| Old Name | New Name |
|----------|----------|
| Disk Clean.sh | Maintain - Disk Clean.sh |
| Docker-Clean.sh | Maintain - Docker Clean.sh |
| Kernel Prune.sh | Maintain - Kernel Prune.sh |

### Crontab
| Old Name | New Name |
|----------|----------|
| Check - ClamScan Crontab.sh | Cron - ClamScan Entry.sh |
| Check Nala Update Crontab.sh | Cron - Nala Update Entry.sh |
| Check Reboot Crontab.sh | Cron - Weekly Reboot Entry.sh |

### OS Scripts / Updates
| Old Name | New Name |
|----------|----------|
| DNS Config.sh | OS - DNS Config.sh |
| Update.sh | Software Management - OS Update.sh |

### Software Management
| Old Name | New Name |
|----------|----------|
| Install ClamAV.sh | Software Management - Install ClamAV.sh |
| Install Nala.sh | Software Management - Install Nala.sh |
| repo-health-check.sh | Software Management - Repo Health Check.sh |
| list-third-party-repos.sh | Software Management - Third Party Repos List.sh |
| check-broken-packages.sh | Software Management - Broken Packages Check.sh |
| list-snap-flatpak.sh | Software Management - List Snap Flatpak.sh |

### TRMM Agent
| Old Name | New Name |
|----------|----------|
| Linux Agent Version.sh | Agent - TRMM Version.sh |
| Linux Agent Update.sh | Agent - TRMM Update.sh |

### Wazuh Agent
| Old Name | New Name |
|----------|----------|
| Wazuh - Fetch Agent Group [LIN].sh | Agent - Wazuh Fetch Group.sh |
| Wazuh - Linux Install.sh | Agent - Wazuh Install.sh |
| Wazuh - Linux Update.sh | Agent - Wazuh Update.sh |
| Wazuh Agent Version.sh | Agent - Wazuh Version.sh |

### Customization
| Old Name | New Name |
|----------|----------|
| Custom_ Bashrc.sh | Customize - Global Bashrc.sh |

### Proxmox Audit
| Old Name | New Name |
|----------|----------|
| Audit_ Proxmox VM_LXC Inventory Script.sh | Audit - Proxmox VM LXC Inventory.sh |

Additional Windows rename batches pending.
## Windows PowerShell Rename Batch
| Old Name | New Name |
|----------|----------|
| List-Services.ps1 | Collect - Services List.ps1 |
| List-LocalUsersAndGroups.ps1 | Collect - Local Users And Groups.ps1 |
| Check-BitLockerStatus.ps1 | Security - BitLocker Status.ps1 |
| List-StartupPrograms.ps1 | Collect - Startup Programs.ps1 |
| Clear-AllPrintQueues.ps1 | Maintain - Clear All Print Queues.ps1 |
| Check-Domain-Connection.ps1 | Check - Domain Connection.ps1 |
| Check-Group-Policy-Compliacnce.ps1 | Audit - Group Policy Compliance.ps1 |
| Device Check_ Software Install - Reports new installs.ps1 | Audit - Recent Software Installs.ps1 |
| Device Check_ Windows Firewall - Check Status.ps1 | Security - Windows Firewall Status.ps1 |
| Device Check_Backup Software.ps1 | Check - Backup Software Presence.ps1 |
| Device Check_BSOD Detect.ps1 | Check - Recent BSOD Events.ps1 |
| Device Check_Pending 3rd Party Updates.ps1 | Check - Pending Third Party Updates.ps1 |
| Device Check_Recently Installed.ps1 | Collect - Recently Installed Programs.ps1 |
| Device Check_TPM Status & BitLocker Readiness.ps1 | Security - TPM BitLocker Readiness.ps1 |
| Device Info_ System Uptime [WIN].ps1 | Monitor - System Uptime.ps1 |
| BIOS - Check Info.ps1 | Collect - BIOS Info.ps1 |
| DomainFetch.ps1 | Collect - Domain Membership.ps1 |
| Fetch_ Winget Source Status.ps1 | Check - Winget Source Status.ps1 |
| Generate-Defender-Score.ps1 | Audit - Defender Configuration Score.ps1 |
| Installed Programs on Device.ps1 | Collect - Installed Programs.ps1 |
| OS Build.ps1 | Collect - OS Build.ps1 |
| SysUptime.ps1 | Monitor - System Uptime.ps1 |
| Clean-PrintQueuesAndRestartSpooler.ps1 | Maintain - Clean Print Queues And Restart Spooler.ps1 |
| Disable-RdpUdpTransport.ps1 | Security - Disable RDP UDP Transport.ps1 |
## Windows Batch Rename Batch
| Old Name | New Name |
|----------|----------|
| SystemInfo.bat | Collect - System Info.bat |
| Flush-DNS.bat | Maintain - Flush DNS Cache.bat |
| List-NetworkInterfaces.bat | Collect - Network Interfaces.bat |
| Show-OpenPorts.bat | Collect - Open Ports.bat |
| Clear-TempFiles.bat | Maintain - Clear Temp Files.bat |
| List-InstalledPrograms.bat | Collect - Installed Programs.bat |
| Check-DiskSpace.bat | Check - Disk Space.bat |
| Restart-PrintSpooler.bat | Maintain - Restart Print Spooler.bat |
| Enable-Firewall.bat | Security - Enable Firewall.bat |
| Disable-Firewall.bat | Security - Disable Firewall.bat |
| Ping-Test-MultiHost.bat | Check - Multi Host Ping Test.bat |
| List-NetworkDrives.bat | Collect - Network Drives.bat |
| List-OpenNetworkConnections.bat | Collect - Open Network Connections.bat |
