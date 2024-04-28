#!/bin/bash 
# Check if ClamAV is enabled
if systemctl is-active --quiet clamav-daemon; then
    echo "ClamAV is enabled and running."
    exit 0
else
    echo "ClamAV is not enabled or not running."
    exit 1
fi