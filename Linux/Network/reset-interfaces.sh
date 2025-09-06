#!/bin/bash
# Reset all network interfaces (down and up)
for iface in $(ls /sys/class/net | grep -v lo); do
    echo "Resetting $iface..."
    sudo ip link set "$iface" down
    sleep 1
    sudo ip link set "$iface" up
    echo "$iface reset complete."
done
