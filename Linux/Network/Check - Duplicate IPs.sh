#!/usr/bin/env bash
# Check - Duplicate IPs (from check-duplicate-ips.sh)
command -v arping >/dev/null 2>&1 || { echo "Install arping"; exit 1; }
for iface in $(ls /sys/class/net | grep -v lo); do ip -4 addr show "$iface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | while read -r ip; do echo "Checking $ip on $iface"; arping -D -I "$iface" "$ip" -c 2; done; done
exit 0