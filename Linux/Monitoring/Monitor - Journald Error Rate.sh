#!/usr/bin/env bash
# Monitor - Journald Error Rate (from journald-error-rate.sh)
WARN="${ERROR_RATE_WARN:-50}"; COUNT=$(journalctl -p 0..3 --since "1 hour ago" --no-pager 2>/dev/null | wc -l || echo 0)
if [ "$COUNT" -ge "$WARN" ]; then echo "ALERT: $COUNT high-priority entries (threshold $WARN)"; exit 1; fi
echo "Journal errors last hour: $COUNT (threshold $WARN)"; exit 0