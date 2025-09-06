#!/bin/bash
# Show the status of the firewall (UFW, firewalld, or iptables)
if command -v ufw &> /dev/null; then
    echo "UFW status:"
    sudo ufw status verbose
elif command -v firewall-cmd &> /dev/null; then
    echo "firewalld status:"
    sudo firewall-cmd --state
    sudo firewall-cmd --list-all
else
    echo "iptables rules:"
    sudo iptables -L -n -v
fi
