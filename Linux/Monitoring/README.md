# 📊 Monitoring

Welcome to the **Monitoring** folder! Here you'll find scripts to help you keep a close eye on your Linux systems' health and performance.

## 📂 Folder Description
This folder is your toolkit for:
- Disk space monitoring
- Agent status checks
- Resource usage tracking

---

## 📜 Script List & Descriptions
| Script | Description |
|--------|-------------|
| **Check - DiskSpace.sh** | Monitors disk space usage and alerts when running low. |
| **Check - MeshAgent_is_running.sh** | Checks if MeshAgent is running for remote management. |
| **Check - Remotely_is_running.sh** | Verifies Remotely agent status for remote access. |
| **Check - Patchmon Agent is installed.sh** | Checks if Patchmon Agent is installed and whether its systemd service is active. |
| **Check - SwapSpace.sh** | Monitors swap space usage and availability. |
| **Check - Wazuh_is_running.sh** | Checks if Wazuh agent is running for security monitoring. |
| **CPU_Usage.sh** | Reports CPU usage statistics. |
| **Disk IO Activity.sh** | Monitors disk I/O activity for performance analysis. |
| **Process Monitor.sh** | Tracks running processes and resource consumption. |
| **RAM_Usage.sh** | Reports RAM usage and availability. |
| **network-bandwidth-monitor.sh** | Monitors network bandwidth usage in real-time. |
| **uptime-trend.sh** | Tracks uptime samples to detect frequent reboots over last 24h (env: UPTIME_LOG_PATH, REBOOT_THRESHOLD). |
| **dns-resolution-latency.sh** | Measures DNS resolution latency for configured hosts and alerts on slow/unresolved (env: HOSTS, DNS_LATENCY_WARN). |
| **journald-error-rate.sh** | Counts high-priority (err+) journal entries in last hour to spot systemic issues (env: ERROR_RATE_WARN). |
| **orphan-process-check.sh** | Detects orphaned (PPID=1) and zombie processes (env: ORPHAN_WARN, ZOMBIE_WARN). |
| **cron-integrity-monitor.sh** | Hashes system/user crontabs to detect unauthorized changes (env: CRON_BASELINE, CRON_REFRESH). |
| **docker-container-health-summary.sh** | Summarizes container health & restart counts (env: UNHEALTHY_WARN, RESTART_WARN). |
| **image-staleness-report.sh** | Reports stale & dangling Docker images by age threshold (env: IMAGE_STALE_DAYS, IMAGE_STALE_WARN). |

---

## ✨ Why Use These Scripts?
- **Visibility:** Stay informed about system health.
- **Proactivity:** Catch issues before they impact users.
- **Automation:** Integrate with alerting and dashboards.

---

---

## 🔔 Alerting & Integration
Many scripts support optional Gotify notifications. Set these environment variables (via your RMM or shell):

```
GOTIFY_URL=https://gotify.example.com
GOTIFY_TOKEN=YOUR_APP_TOKEN
```

They will automatically post alerts when thresholds are exceeded. Adjust per-script thresholds with the environment variables noted in the table above.

## 🧪 Exit Codes Convention
| Exit Code | Meaning |
|-----------|---------|
| 0 | Normal / within thresholds |
| 1 | Alert condition met (threshold exceeded or integrity change) |

Use exit codes in automation pipelines to trigger remediation or ticket creation.

## 🚀 Quick Usage Examples
```bash
# Detect frequent reboots
REBOOT_THRESHOLD=2 ./uptime-trend.sh

# DNS latency with custom hosts
HOSTS="google.com,example.com" DNS_LATENCY_WARN=250 ./dns-resolution-latency.sh

# Journal error surge
ERROR_RATE_WARN=100 ./journald-error-rate.sh

# Refresh cron baseline
CRON_REFRESH=1 ./cron-integrity-monitor.sh

# Docker health
UNHEALTHY_WARN=0 RESTART_WARN=3 ./docker-container-health-summary.sh
```

---

Happy monitoring! 📈
