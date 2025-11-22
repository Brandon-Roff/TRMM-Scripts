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
| **Check - Disk Space.sh** | Monitors disk space usage and alerts when running low. |
| **Agent - MeshAgent Status.sh** | Checks if MeshAgent is running and attempts restart if stopped. |
| **Agent - Remotely Status.sh** | Verifies Remotely agent status and attempts restart if stopped. |
| **Agent - Patchmon Status.sh** | Determines Patchmon install & service state. |
| **Monitor - Swap Usage.sh** | Monitors swap usage percentage with simple threshold. |
| **Agent - Wazuh Status.sh** | Checks Wazuh agent state and attempts restart if stopped. |
| **Monitor - CPU Usage.sh** | Reports CPU usage statistics with tiered exit codes. |
| **Monitor - Disk IO Activity.sh** | Streams disk I/O activity for performance analysis. |
| **Monitor - Process Snapshot.sh** | Shows top CPU and memory processes. |
| **Monitor - RAM Usage.sh** | Reports RAM usage with alert thresholds. |
| **Monitor - Network Bandwidth.sh** | Monitors instantaneous network bandwidth usage. |
| **Monitor - Uptime Trend.sh** | Tracks uptime to detect frequent reboots (env: UPTIME_LOG_PATH, REBOOT_THRESHOLD). |
| **Check - DNS Resolution Latency.sh** | Measures DNS resolution latency (env: HOSTS, DNS_LATENCY_WARN). |
| **Monitor - Journald Error Rate.sh** | Counts high-priority journal entries (env: ERROR_RATE_WARN). |
| **Check - Orphan Zombie Processes.sh** | Detects orphaned and zombie processes (env: ORPHAN_WARN, ZOMBIE_WARN). |
| **Audit - Cron Integrity.sh** | Hashes cron sources to detect unauthorized changes (env: CRON_BASELINE, CRON_REFRESH). |
| **Monitor - Docker Container Health.sh** | Summarizes container health & restart counts (env: UNHEALTHY_WARN, RESTART_WARN). |
| **Image - Stale Images Report.sh** | Reports stale & dangling Docker images (env: IMAGE_STALE_DAYS, IMAGE_STALE_WARN). |

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
