# 🌐 Network

Welcome to the **Network** folder! Here you'll find scripts for managing, troubleshooting, and auditing network settings and connectivity on Linux systems.

## 📂 Folder Description
This folder is your toolkit for:
- Network configuration
- Connectivity checks
- Troubleshooting network issues

---

## 📜 Script List & Descriptions
| Script | Description |
|--------|-------------|
| disable-ipv6.sh | Disables IPv6 on all interfaces (runtime and persistent) for enhanced compatibility and security. |
| show-dns.sh     | Outputs current DNS configuration for all interfaces, including /etc/resolv.conf and common network managers. |
| list-docker-networks.sh | Lists all Docker networks and inspects their details for container networking troubleshooting. |
| test-internet.sh | Tests internet connectivity by pinging common hosts (8.8.8.8, 1.1.1.1, google.com). |
| show-interfaces.sh | Lists all active network interfaces and their IP addresses. |
| port-scan.sh | Scans open ports on localhost or a target using ss or nmap. |
| reset-interfaces.sh | Resets all network interfaces by bringing them down and up. |
| show-routes.sh | Displays the current routing table. |
| check-duplicate-ips.sh | Checks for duplicate IP addresses on the local network using arping. |
| speed-test.sh | Runs a speed test using speedtest-cli. |
| firewall-status.sh | Shows firewall status for UFW, firewalld, or iptables. |
| show-arp.sh | Displays the ARP table for local network mapping. |


---

## ✨ Why Use These Scripts?
- **Reliability:** Ensure your systems are always connected.
- **Troubleshooting:** Quickly diagnose and resolve network issues.
- **Automation:** Streamline network management tasks.

---

Happy networking! 🚀
