#!/bin/sh
port=$(grep -oP '^Port\s+\K\d+' /etc/ssh/sshd_config)
if [ -z "$port" ]; then
    default_port=22  # Default SSH port
    echo "$default_port"
else
    echo "$port"
fi