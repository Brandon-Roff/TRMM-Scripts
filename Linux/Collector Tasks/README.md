# 🚀 Collector Scripts to use on Linux Tactical RMM Agents

Welcome to the **Collector Scripts for Tactical Agent** Folder! This Folder contains a collection of scripts designed to be run using Tactical RMM with the Tactical agent.

## 📜 Scripts Overview

### 1. [Check Docker is Running.sh](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Collector%20Tasks/Check%20Docker%20is%20Running.sh)

- **Description**: This will check if docker is running.
- **NOTE*:* Can always add compose too if need to be.


### 2. [Check SSH is Running.sh](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Collector%20Tasks/Check%20SSH%20is%20Running.sh)

- **Description**: Check if SSH is Running.


### 3. [ClamAV Check.sh](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Collector%20Tasks/ClamAV%20Check.sh)

- **Description**: Check if Clamav/ClamScan is Running.


### 4. [Nala Install Status.sh](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Collector%20Tasks/Nala%20Install%20Status.sh)

- **Description**: Check if Nala Package manager is installed if not attempt to install it.
- **NOTE:** Worth checking there Project [here](https://gitlab.com/volian/nala).


### 5. [SSH Port Fetch.sh](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Collector%20Tasks/SSH%20Port%20Fetch.sh)

- **Description**: Fetchs the Port for ssh, even if its not 22.
- **NOTE**: This should be Changed as a default.


### 6. [SSH Root Access.sh](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Collector%20Tasks/SSH%20Root%20Access.sh)

- **Description**: Checks to make sure that the root user is disabled from SSH.
- **NOTE**: This should be done as a default.


### 7. [UFW Status.sh](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Collector%20Tasks/UFW%20Status.sh)

- **Description**: Checks to see active status of UFW.
- **NOTE**: This should Setup as a default. [here](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Security/UFW/UFW_%20Install%20and%20Prevision%20firewall.sh) is a script to install and preprovision your server with UFW


### 8. [Unattended Upgrades.sh](https://github.com/Brandon-Roff/TRMM-Scripts/blob/main/Linux/Collector%20Tasks/Unattended%20Upgrades.sh)

- **Description**: Checks to see if unatended upgrades is installed if not try to install it
- **NOTE**: This should be done as a default.





## 🛣️ Roadmap
## Short-term Goals (1-6 months)
### Script Enhancements and Maintenance
- [ ] Add Docker Compose Check: Enhance the existing "Check Docker is Running" script to include a check for Docker Compose.
- [ ] Update Default SSH Port Check: Modify the "SSH Port Fetch" script to handle custom configurations and provide more comprehensive reporting.
- [ ] Enhance UFW Script: Update the "UFW Status" script to provide more detailed output, including active rules and logging status.

### New Monitoring Scripts
- [ ] **Service Status Check**
  - [ ] Create scripts to check the status of additional critical services like Apache, Nginx, MySQL, and PostgreSQL.
- [ ] **Resource Monitoring**
  - [ ] Develop scripts to monitor CPU usage, memory usage, disk space, and network activity.
- [ ] **Log File Monitoring**
  - [ ] Write scripts to check and report on specific log file entries, such as /var/log/syslog or /var/log/auth.log.

## Mid-term Goals (6-12 months)
### Security and Compliance
- [ ] **Firewall Rule Checker**
  - [ ] Develop a script to verify custom firewall rules and compare them against a predefined security baseline.
- [ ] **Rootkit Check**
  - [ ] Create a script to check for the presence of rootkits using tools like chkrootkit or rkhunter.
- [ ] **SELinux/AppArmor Status**
  - [ ] Write scripts to check the status and configuration of SELinux or AppArmor policies.

### Automation and Remediation
- [ ] **Automatic Service Restarts**
  - [ ] Develop scripts that not only check service status but also attempt to restart the service if it is found to be stopped.
- [ ] **Patch Management**
  - [ ] Create a comprehensive script for checking, downloading, and applying security patches across multiple distributions.

## Long-term Goals (12-24 months)
### Advanced Monitoring and Analytics
- [ ] **Performance Metrics Collection**
  - [ ] Develop scripts that collect performance metrics over time and integrate with monitoring tools like Prometheus or Grafana.




