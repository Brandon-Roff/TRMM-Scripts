#!/usr/bin/env bash
# Monitor - Uptime Trend (from uptime-trend.sh)
LOG_FILE="${UPTIME_LOG_PATH:-/var/log/uptime-trend.log}"; REBOOT_THRESHOLD="${REBOOT_THRESHOLD:-3}"; NOW_TS=$(date +%s); UPTIME_SEC=$(awk '{print int($1)}' /proc/uptime)
mkdir -p "$(dirname "$LOG_FILE")" || true
echo "$NOW_TS $UPTIME_SEC" >> "$LOG_FILE"
CUTOFF=$((NOW_TS - 86400)); REBOOTS=0; PREV=-1
while read -r TS U; do [ "$TS" -lt "$CUTOFF" ] && continue; if [ "$PREV" -ge 0 ] && [ "$U" -lt "$PREV" ]; then REBOOTS=$((REBOOTS+1)); fi; PREV=$U; done < "$LOG_FILE"
if [ "$REBOOTS" -ge "$REBOOT_THRESHOLD" ]; then echo "ALERT: $REBOOTS reboots in 24h (threshold $REBOOT_THRESHOLD)"; exit 1; fi
echo "Uptime OK. Reboots 24h: $REBOOTS (threshold $REBOOT_THRESHOLD)"; exit 0