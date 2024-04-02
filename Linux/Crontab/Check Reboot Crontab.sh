#!/bin/sh
# Check if the crontab entry exists if not adds it
if crontab -l | grep -q '0 3 \* \* 0 /sbin/shutdown -r now'; then
    echo "Crontab entry to reboot every Sunday at 3 am already exists."
    exit 0
else
    echo "$reboot_time 3 * * 0 /sbin/shutdown -r now" | crontab -
    if [ $? -eq 0 ]; then
        echo "Crontab entry added successfully."
        exit 0
    else
        echo "Failed to add crontab entry."
        exit 1
    fi
fi