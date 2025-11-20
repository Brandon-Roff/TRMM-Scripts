#!/usr/bin/env bash
# uptime-trend.sh - Track system uptime across runs and detect frequent reboots.
# Env Vars:
#   UPTIME_LOG_PATH (default /var/log/uptime-trend.log) - file storing historical uptime seconds
#   REBOOT_THRESHOLD (default 3) - alert if number of reboots in last 24h exceeds this
#   GOTIFY_URL / GOTIFY_TOKEN - if set, send Gotify notification on alert
# Exit codes:
#   0 normal, 1 alert condition
set -euo pipefail

LOG_FILE="${UPTIME_LOG_PATH:-/var/log/uptime-trend.log}"
REBOOT_THRESHOLD="${REBOOT_THRESHOLD:-3}"
NOW_TS=$(date +%s)
UPTIME_SEC=$(awk '{print int($1)}' /proc/uptime)

mkdir -p "$(dirname "$LOG_FILE")" || true

# Append current uptime with timestamp
echo "$NOW_TS $UPTIME_SEC" >> "$LOG_FILE"

# Determine reboot events: a reboot implies uptime less than previous sample.
# Consider only samples within last 24h.
CUTOFF=$((NOW_TS - 86400))
REBOOTS=0
PREV_UP=-1
while read -r TS U; do
  [ "$TS" -lt "$CUTOFF" ] && continue
  if [ "$PREV_UP" -ge 0 ] && [ "$U" -lt "$PREV_UP" ]; then
    REBOOTS=$((REBOOTS + 1))
  fi
  PREV_UP=$U
done < "$LOG_FILE"

ALERT="false"
MSG="Uptime trend OK. Reboots in last 24h: $REBOOTS (threshold: $REBOOT_THRESHOLD). Current uptime: ${UPTIME_SEC}s"
if [ "$REBOOTS" -ge "$REBOOT_THRESHOLD" ]; then
  ALERT="true"
  MSG="Frequent reboots detected: $REBOOTS in last 24h (threshold $REBOOT_THRESHOLD). Current uptime ${UPTIME_SEC}s"
fi

if [ "$ALERT" = "true" ] && [ -n "${GOTIFY_URL:-}" ] && [ -n "${GOTIFY_TOKEN:-}" ]; then
  curl -s -X POST "${GOTIFY_URL}/message?token=${GOTIFY_TOKEN}" -F "title=Uptime Alert" -F "message=${MSG}" -F "priority=5" >/dev/null || true
fi

echo "$MSG"
[ "$ALERT" = "true" ] && exit 1 || exit 0
