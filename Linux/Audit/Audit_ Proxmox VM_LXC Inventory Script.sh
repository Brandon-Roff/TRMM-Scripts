#!/bin/bash

NODE=$(hostname)

echo "=== Proxmox VM/LXC Inventory on node: $NODE ==="
printf "%-8s %-20s %-10s %-6s\n" "ID" "NAME" "STATUS" "TYPE"
printf "%-8s %-20s %-10s %-6s\n" "--------" "--------------------" "----------" "------"

# QEMU VMs
for vmid in $(pvesh get /nodes/"$NODE"/qemu --output-format=json | jq -r '.[].vmid'); do
  output=$(pvesh get /nodes/"$NODE"/qemu/"$vmid"/status/current --output-format=json 2>/dev/null)
  if [ -n "$output" ]; then
    name=$(echo "$output" | jq -r '.name // "N/A"')
    status=$(echo "$output" | jq -r '.status // "N/A"')
    printf "%-8s %-20s %-10s %-6s\n" "$vmid" "$name" "$status" "QEMU"
  fi
done

# LXC containers
for vmid in $(pvesh get /nodes/"$NODE"/lxc --output-format=json | jq -r '.[].vmid'); do
  output=$(pvesh get /nodes/"$NODE"/lxc/"$vmid"/status/current --output-format=json 2>/dev/null)
  if [ -n "$output" ]; then
    name=$(echo "$output" | jq -r '.name // "N/A"')
    status=$(echo "$output" | jq -r '.status // "N/A"')
    printf "%-8s %-20s %-10s %-6s\n" "$vmid" "$name" "$status" "LXC"
  fi
done
