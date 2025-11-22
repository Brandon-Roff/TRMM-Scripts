[![TRMM LOGO](https://docs.tacticalrmm.com/images/onit.ico)](https://docs.tacticalrmm.com/)


# TacticalRMM Scripts Repository

Welcome to the TacticalRMM Scripts repository! Here, you'll discover an array of meticulously crafted scripts tailored to augment and extend the capabilities of TacticalRMM across Windows and Linux systems.

## 🚀 Usage

1. **Navigate** to the folder corresponding to your system (`Windows` or `Linux`).
2. **Select** the script best suited for your requirements.
3. **Download** the chosen script to your TacticalRMM server or workstation.
4. **Follow** any accompanying instructions or documentation provided with the script for seamless integration.

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

| Category            | Description                                 | Link |
|---------------------|---------------------------------------------|------|
| Tactical RMM Agent  | Scripts related to the Tactical RMM Agent   | [Link](Windows/Powershell/TRMM%20Agent) |
| Wazuh Agent         | Scripts related to the Wazuh Agent          | [Link](Windows/Powershell/Wazuh%20Agent) |
| Collector Scripts   | Scripts for pulling data from Windows clients| [Link](Windows/Powershell/Collector%20Scripts) |
| Apps                | Scripts for app list/install/uninstall      | [Link](Windows/Powershell/Apps) |
| Checks              | Device and system checks                    | [Link](Windows/Powershell/Checks) |
| Quick Fixes         | Quick remediation scripts                   | [Link](Windows/Powershell/Quick%20Fixes) |
| AV                  | Antivirus related scripts                   | [Link](Windows/Powershell/AV) |
| Network             | Network configuration and troubleshooting scripts | [Link](Windows/Powershell/Network) |

#### Batch

| Category | Description | Link |
|----------|-------------|------|
| Batch Scripts | Batch scripts for Windows (console output, admin tools, troubleshooting) | [Link](Windows/Batch/README.md) |
 

### Linux 🐧

| Category            | Description                                 | Link |
|---------------------|---------------------------------------------|------|
| Audit               | Audit scripts for Proxmox VM/LXC            | [Link](Linux/Audit) |
| Collector Tasks     | Data collection scripts for Linux clients   | [Link](Linux/Collector%20Tasks) |
| Crontab             | Crontab related scripts                     | [Link](Linux/Crontab) |
| Customization       | Custom bashrc and environment scripts       | [Link](Linux/Customization) |
| Maintenance         | Disk and kernel maintenance scripts         | [Link](Linux/Maintenance) |
| Monitoring          | System monitoring scripts                   | [Link](Linux/Monitoring) |
| Network             | Network configuration and troubleshooting scripts | [Link](Linux/Network) |
| OS Scripts          | OS configuration and update scripts         | [Link](Linux/OS%20Scripts) |
| Security            | Security and audit scripts                  | [Link](Linux/Security) |
| Software Management | Software install and management scripts     | [Link](Linux/Software%20Management) |
| TRMM Agent          | TRMM agent update/version scripts           | [Link](Linux/TRMM%20Agent) |
| Wazuh Agent         | Wazuh agent install/update/version scripts  | [Link](Linux/Wazuh%20Agent) |




## 🌟 Contributing

We warmly welcome contributions from our vibrant community to enrich the repository with innovative scripts. If you've crafted a script that could benefit other TacticalRMM users, feel free to submit a pull request adhering to our contribution guidelines.

## 🔑 License

This repository is licensed under the [MIT License](LICENSE), granting you the freedom to utilize, modify, and distribute the scripts for both personal and commercial use. Kindly ensure compliance with the terms outlined in the license file.

## 🚨 Disclaimer

The scripts provided herein are designed for use at your discretion and risk. While we endeavor to maintain their reliability and efficacy, we cannot guarantee their performance across all environments. Prior to deploying scripts to critical systems, always conduct thorough testing in non-production environments. We disclaim any liability for damages or losses arising from script usage.

## 🔗 TacticalRMM Links

- [TacticalRMM Project Repo](https://github.com/amidaware/tacticalrmm)
- [TacticalRMM Project Documentation](https://docs.tacticalrmm.com/)

### 📐 Naming Convention

Scripts follow: `Category - Descriptive Title.ext`. Key categories: Check, Monitor, Audit, Collect, Software Management, Security, Network, Agent, Maintain, Customize, Cron, Image. See `NAMING-CONVENTION.md` for details and current rename batches.

Happy scripting! 🌈
