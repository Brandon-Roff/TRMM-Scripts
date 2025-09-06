#!/bin/bash
if ! command -v arping &> /dev/null; then
    echo "arping is required. Install with: sudo apt install arping"
    exit 1
fi

for iface in $(ls /sys/class/net | grep -v lo); do
    ip -4 addr show "$iface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | while read -r ip; do
        echo "Checking $ip on $iface..."
        arping -D -I "$iface" "$ip" -c 2
    done
done
