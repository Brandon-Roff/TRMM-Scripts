#!/usr/bin/env bash
# Audit - Cron Integrity (from cron-integrity-monitor.sh)
BASELINE="${CRON_BASELINE:-/var/log/cron-baseline.sha256}"; REFRESH="${CRON_REFRESH:-0}"; TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
OUT="$TMP/cron.txt"
{ echo "### /etc/crontab"; [ -f /etc/crontab ] && cat /etc/crontab || echo "(missing)"; echo "\n### /etc/cron.d"; [ -d /etc/cron.d ] && cat /etc/cron.d/* 2>/dev/null || echo "(empty)"; echo "\n### user crontabs"; for u in $(cut -d: -f1 /etc/passwd); do CT=$(crontab -u "$u" -l 2>/dev/null || true); [ -n "$CT" ] && { echo "-- $u"; echo "$CT"; }; done; } > "$OUT"
CUR=$(sha256sum "$OUT" | awk '{print $1}')
if [ "$REFRESH" = "1" ] || [ ! -f "$BASELINE" ]; then echo "$CUR" > "$BASELINE"; echo "Baseline refreshed: $CUR"; exit 0; fi
OLD=$(cat "$BASELINE"); if [ "$CUR" != "$OLD" ]; then echo "ALERT: Cron integrity changed old=$OLD new=$CUR"; exit 1; fi
echo "Cron integrity OK hash=$CUR"; exit 0