#!/bin/bash

# Configuration
KNOWN_PORTS_FILE="/var/log/known_ports.txt"
ALERT_FILE="/var/log/port_scan_alert.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "=== 🔍 Port Scan Monitor ==="
echo "Date: $DATE"

# Get currently open ports (excluding localhost)
current_ports=$(ss -tuln | awk '/LISTEN/ {print $5}' | grep -oE '[0-9]+$' | sort -n | uniq)

# First run
if [ ! -f "$KNOWN_PORTS_FILE" ]; then
    echo "⚠️ First run. Saving current ports to $KNOWN_PORTS_FILE"
    echo "$current_ports" > "$KNOWN_PORTS_FILE"
    exit 0
fi

# Compare with known ports
known_ports=$(cat "$KNOWN_PORTS_FILE")
new_ports=$(comm -13 <(echo "$known_ports") <(echo "$current_ports"))

# Alert if new ports are found
if [ -n "$new_ports" ]; then
    echo "🚨 New unexpected ports detected:"
    echo "$new_ports"
    
    {
        echo "[$DATE] ALERT: New open ports detected:"
        echo "$new_ports"
        echo
    } >> "$ALERT_FILE"


else
    echo "✅ No unexpected ports open."
fi

# Update known ports
echo "$current_ports" > "$KNOWN_PORTS_FILE"
