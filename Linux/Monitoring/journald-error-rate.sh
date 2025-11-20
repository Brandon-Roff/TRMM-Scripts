#!/usr/bin/env bash
# journald-error-rate.sh - Count high priority journal entries over the last hour.
# Env Vars:
#   ERROR_RATE_WARN (default 50) - alert if error+critical+alert+emerg entries exceed this in last hour
#   GOTIFY_URL / GOTIFY_TOKEN for alerting.
# Requires: journalctl
# Exit codes: 0 normal, 1 threshold exceeded
set -euo pipefail
ERROR_RATE_WARN="${ERROR_RATE_WARN:-50}"

# Priorities: 0(emerg) 1(alert) 2(crit) 3(err)
COUNT=$(journalctl -p 0..3 --since "1 hour ago" --no-pager 2>/dev/null | wc -l || echo 0)
MSG="Journal high-priority entries (last hour): $COUNT (threshold $ERROR_RATE_WARN)"

if [ "$COUNT" -ge "$ERROR_RATE_WARN" ]; then
  ALERT_MSG="Excessive journal errors: $COUNT in last hour (threshold $ERROR_RATE_WARN)"
  if [ -n "${GOTIFY_URL:-}" ] && [ -n "${GOTIFY_TOKEN:-}" ]; then
    curl -s -X POST "${GOTIFY_URL}/message?token=${GOTIFY_TOKEN}" -F "title=Journal Errors" -F "message=${ALERT_MSG}" -F "priority=6" >/dev/null || true
  fi
  echo "$ALERT_MSG"; exit 1
fi

echo "$MSG"; exit 0
