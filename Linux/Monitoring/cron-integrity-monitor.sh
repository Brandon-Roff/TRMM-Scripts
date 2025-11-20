#!/usr/bin/env bash
# cron-integrity-monitor.sh - Detect changes to system/user crontab definitions via hashing.
# Env Vars:
#   CRON_BASELINE (default /var/log/cron-baseline.sha256)
#   CRON_ALERT (default true) - set to 'false' to disable alerting
#   GOTIFY_URL / GOTIFY_TOKEN for alerting
#   CRON_REFRESH=1 to force baseline refresh
# Exit codes: 0 unchanged, 1 changed
set -euo pipefail
BASELINE="${CRON_BASELINE:-/var/log/cron-baseline.sha256}"
REFRESH="${CRON_REFRESH:-0}"
ALERT_FLAG="${CRON_ALERT:-true}"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

OUT_FILE="$TMP_DIR/cron-current.txt"

# Collect system crontab and per-user crontabs
{
  echo "### system-wide /etc/crontab"; [ -f /etc/crontab ] && cat /etc/crontab || echo "(missing)";
  echo "\n### /etc/cron.d"; [ -d /etc/cron.d ] && cat /etc/cron.d/* 2>/dev/null || echo "(empty)";
  echo "\n### user crontabs";
  for u in $(cut -d: -f1 /etc/passwd); do
    CT=$(crontab -u "$u" -l 2>/dev/null || true)
    [ -n "$CT" ] && { echo "-- $u"; echo "$CT"; }
  done
} > "$OUT_FILE"

CURRENT_HASH=$(sha256sum "$OUT_FILE" | awk '{print $1}')

if [ "$REFRESH" = "1" ] || [ ! -f "$BASELINE" ]; then
  echo "$CURRENT_HASH" > "$BASELINE"
  echo "Baseline refreshed. Hash: $CURRENT_HASH"
  exit 0
fi

BASE_HASH=$(cat "$BASELINE")
if [ "$CURRENT_HASH" != "$BASE_HASH" ]; then
  MSG="Crontab integrity change detected! Old:$BASE_HASH New:$CURRENT_HASH"
  if [ "$ALERT_FLAG" = "true" ] && [ -n "${GOTIFY_URL:-}" ] && [ -n "${GOTIFY_TOKEN:-}" ]; then
    curl -s -X POST "${GOTIFY_URL}/message?token=${GOTIFY_TOKEN}" -F "title=Cron Integrity" -F "message=${MSG}" -F "priority=6" >/dev/null || true
  fi
  echo "$MSG"; exit 1
fi

echo "Cron integrity OK. Hash: $CURRENT_HASH"; exit 0
