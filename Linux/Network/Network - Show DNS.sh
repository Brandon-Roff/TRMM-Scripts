#!/usr/bin/env bash
# Network - Show DNS (from show-dns.sh)
echo "DNS (/etc/resolv.conf):"; cat /etc/resolv.conf
if command -v nmcli >/dev/null 2>&1; then echo "\nNetworkManager DNS:"; nmcli dev show | grep 'IP4.DNS\|IP6.DNS'; fi
if command -v systemd-resolve >/dev/null 2>&1; then echo "\nsystemd-resolved DNS:"; systemd-resolve --status | grep 'DNS Servers' -A2; fi
exit 0