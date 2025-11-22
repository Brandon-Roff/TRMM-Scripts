# 🔒 Security

Welcome to the **Security** folder! Here you'll find scripts and subfolders dedicated to hardening, auditing, and monitoring your Linux systems for maximum protection.

## 📂 Folder Description
This folder is your toolkit for:
- User access audits
- Security compliance checks
- Firewall management

---

## 📜 Subfolders & Descriptions
| Subfolder | Description |
|-----------|-------------|
| **Access/** | Scripts for auditing user access and sudo privileges. |
| **Audit/** | Scripts for basic and advanced security audits. |
| **UFW/** | Scripts for installing, configuring, and managing the Uncomplicated Firewall (UFW). |

---

## ✨ Why Use These Scripts?
- **Protection:** Harden your systems against threats.
- **Compliance:** Meet security standards and best practices.
- **Visibility:** Know who has access and what is exposed.

---

### Script Index (Representative)
| Script | Purpose |
|--------|---------|
| **Audit - Basic System.sh** | Enumerates core system security posture. |
| **Audit - Users Overview.sh** | Lists system users with metadata. |
| **Audit - Sudo Users.sh** | Shows users granted sudo privileges. |
| **Audit - Open Ports Diff.sh** | Compares current open ports to baseline for drift. |
| **Audit - Docker Exposure.sh** | Audits Docker containers for exposed/unrestricted services. |
| **Security - UFW Provision.sh** | Installs & configures UFW with sane defaults. |
| **Security - UFW Status.sh** | Reports current firewall status & rules. |
| **Security - SSH Root Access.sh** | Checks if root SSH login is permitted. |

> Note: Some audit scripts reside in sibling folders (Access/, Audit/, UFW/). Consolidated view above for quick navigation.

Stay secure! 🛡️
