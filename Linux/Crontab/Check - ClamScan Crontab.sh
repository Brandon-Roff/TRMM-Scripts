#!/bin/sh

# This script will check if the crontab for ClamScan has been added for periodic scanning if not it will suggest a crontab for your system

if crontab -l 2>/dev/null | grep -q "clamscan"; then
    crontab -l | grep "clamscan"
else
    echo "No clamscan cron job found"
fi
