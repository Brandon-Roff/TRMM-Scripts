#!/bin/bash

# Check if UFW is enabled
if ufw status | grep -q "Status: active"; then
    echo "Enabled."
    exit 0
else
    echo "Disabled."
    exit 1
fi