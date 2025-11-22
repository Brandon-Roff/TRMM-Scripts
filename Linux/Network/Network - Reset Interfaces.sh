#!/usr/bin/env bash
# Network - Reset Interfaces (from reset-interfaces.sh)
for iface in $(ls /sys/class/net | grep -v lo); do echo "Resetting $iface"; sudo ip link set "$iface" down; sleep 1; sudo ip link set "$iface" up; done
echo "All interfaces reset."; exit 0