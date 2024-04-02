![TRMM LOGO](https://docs.tacticalrmm.com/images/onit.ico)

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
- **Powershell**
    - This directory contains PowerShell scripts specifically curated for Windows environments.
    - | Script Name | Description | Link to Script |
        |-------------|-------------|-------------|
        | `script1.ps1` | Description of script 1 | [Link to Script](https://www.google.com) |

- **Batch**
    - This directory contains batch scripts specifically curated for Windows environments.
    - | Script Name | Description | Link to Script |
        |-------------|-------------|-------------|
        | `script1.bat` | Description of script 1 | [Link to Script](https://www.google.com) |

### Linux 🐧
- **Bash**
  - Within this folder, you'll find a selection of Bash scripts meticulously crafted for Linux systems.
  - | Script Name | Description | Link to Script |
      |-------------|-------------|-------------|
      | `Linux Agent Update.sh` |   This script will update the TRMM agent to the latest version based on CPU Type  | [Link to Script](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/TRMM%20Agent/Linux%20Agent%20Update.sh) |  
      | `Linux Agent Version.sh` |   This script will Display TRMM agent version | [Link to Script](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/TRMM%20Agent/Linux%20Agent%20Version.sh) |  
      | `UFW_ Install and Prevision firewall.sh` |   This Script Installs UFW if not already installed, it goes on to enable it if it isn't already, then allows SSH, HTP, HTTPS and SMB ports through firewall | [Link to Script](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/UFW/UFW_%20Install%20and%20Prevision%20firewall.sh) |  
      | `Wazuh - Linux Install.sh` | Will detect OS and CPU Architecture and Install Accordingly, you'll need to to change values accordingly | [Link to Script](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Wazuh/Wazuh%20-%20Linux%20Install.sh) |  
      | `Check Reboot Crontab.sh` |   This script will check if a reboot is scheduled in crontab for 3am every sunday, modify crontab for a diffrent time | [Link to Script](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Crontab/Check%20Reboot%20Crontab.sh) |  
      `Process Monitor.sh` |   This script lists the top CPU and memory-consuming processes, aiding in identifying resource-intensive tasks. | [Link to Script](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Monitoring/Process%20Monitor.sh) |  

## 🌟 Contributing

We warmly welcome contributions from our vibrant community to enrich the repository with innovative scripts. If you've crafted a script that could benefit other TacticalRMM users, feel free to submit a pull request adhering to our contribution guidelines.

## 🔑 License

This repository is licensed under the [MIT License](LICENSE), granting you the freedom to utilize, modify, and distribute the scripts for both personal and commercial use. Kindly ensure compliance with the terms outlined in the license file.

## 🚨 Disclaimer

The scripts provided herein are designed for use at your discretion and risk. While we endeavor to maintain their reliability and efficacy, we cannot guarantee their performance across all environments. Prior to deploying scripts to critical systems, always conduct thorough testing in non-production environments. We disclaim any liability for damages or losses arising from script usage.

## 🔗 TacticalRMM Links

- [TacticalRMM Project Repo](https://github.com/amidaware/tacticalrmm)
- [TacticalRMM Project Documentation](https://docs.tacticalrmm.com/)

Happy scripting! 🌈
