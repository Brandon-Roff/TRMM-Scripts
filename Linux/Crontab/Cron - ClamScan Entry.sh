#!/usr/bin/env bash
# Cron - ClamScan Entry (from Check - ClamScan Crontab.sh)
if crontab -l 2>/dev/null | grep -q "clamscan"; then crontab -l | grep "clamscan"; else echo "No clamscan cron job found"; fi
exit 0