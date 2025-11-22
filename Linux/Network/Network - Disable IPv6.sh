#!/usr/bin/env bash
# Network - Disable IPv6 (from disable-ipv6.sh)
set -e
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
CFG="/etc/sysctl.d/99-disable-ipv6.conf"
{ echo "net.ipv6.conf.all.disable_ipv6 = 1"; echo "net.ipv6.conf.default.disable_ipv6 = 1"; } | sudo tee "$CFG" >/dev/null
sudo sysctl -p "$CFG"
echo "IPv6 disabled (runtime & persistent)."; exit 0