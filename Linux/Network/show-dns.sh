#!/bin/bash

echo "Current DNS configuration (from /etc/resolv.conf):"
cat /etc/resolv.conf

echo
if command -v nmcli &> /dev/null; then
    echo "\nNetworkManager DNS settings:"
    nmcli dev show | grep 'IP4.DNS\|IP6.DNS'
fi

echo
if command -v systemd-resolve &> /dev/null; then
    echo "\nsystemd-resolved DNS settings:"
    systemd-resolve --status | grep 'DNS Servers' -A2
fi
