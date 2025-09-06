#!/bin/bash
# Script to disable IPv6 on all network interfaces (both runtime and persistent)
set -e

echo "Disabling IPv6 on all interfaces (runtime)..."
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

# Make persistent
CONFIG_FILE="/etc/sysctl.d/99-disable-ipv6.conf"
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee $CONFIG_FILE > /dev/null
echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a $CONFIG_FILE > /dev/null

sudo sysctl -p $CONFIG_FILE

echo "IPv6 has been disabled on all interfaces. A reboot may be required for all changes to take effect."
