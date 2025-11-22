#!/usr/bin/env bash
# Audit - Proxmox VM LXC Inventory (from original)
NODE=$(hostname)
printf "%-8s %-22s %-10s %-6s\n" "ID" "NAME" "STATUS" "TYPE"
for vmid in $(pvesh get /nodes/"$NODE"/qemu --output-format=json 2>/dev/null | jq -r '.[].vmid'); do out=$(pvesh get /nodes/"$NODE"/qemu/"$vmid"/status/current --output-format=json 2>/dev/null); [ -n "$out" ] && printf "%-8s %-22s %-10s %-6s\n" "$vmid" "$(echo "$out" | jq -r '.name')" "$(echo "$out" | jq -r '.status')" "QEMU"; done
for vmid in $(pvesh get /nodes/"$NODE"/lxc --output-format=json 2>/dev/null | jq -r '.[].vmid'); do out=$(pvesh get /nodes/"$NODE"/lxc/"$vmid"/status/current --output-format=json 2>/dev/null); [ -n "$out" ] && printf "%-8s %-22s %-10s %-6s\n" "$vmid" "$(echo "$out" | jq -r '.name')" "$(echo "$out" | jq -r '.status')" "LXC"; done
exit 0