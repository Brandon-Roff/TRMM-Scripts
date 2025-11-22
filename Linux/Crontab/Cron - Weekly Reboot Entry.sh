#!/usr/bin/env bash
# Cron - Weekly Reboot Entry (from Check Reboot Crontab.sh)
ENTRY='0 3 * * 0 /sbin/shutdown -r now'
if crontab -l | grep -Fq "$ENTRY"; then echo "Weekly reboot entry present"; exit 0; else (crontab -l 2>/dev/null; echo "$ENTRY") | crontab - && echo "Weekly reboot entry added" && exit 0; fi