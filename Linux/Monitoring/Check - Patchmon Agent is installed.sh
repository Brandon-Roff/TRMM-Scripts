#!/bin/bash

# Check if Patchmon Agent is installed
if command -v patchmon-agent &> /dev/null; then
    echo "Patchmon Agent is installed."
else
    echo "Patchmon Agent is not installed."
fi

# Check the status of Patchmon Agent service
if systemctl is-active --quiet patchmon-agent; then
    echo "Patchmon Agent service is running."
else
    echo "Patchmon Agent service is not running."
fi

# Exit codes
# 0 - Installed and running
# 1 - Not installed and not running
# 2 - Installed but not running

if command -v patchmon-agent &> /dev/null && systemctl is-active --quiet patchmon-agent; then
    exit 0
elif ! command -v patchmon-agent &> /dev/null && ! systemctl is-active --quiet patchmon-agent; then
    exit 1
else
    exit 2
fi

