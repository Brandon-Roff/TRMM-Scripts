#!/bin/bash
# Simple internet connectivity test by pinging common hosts
HOSTS=(8.8.8.8 1.1.1.1 google.com)
for host in "${HOSTS[@]}"; do
    echo "Pinging $host..."
    if ping -c 2 -W 2 "$host" &> /dev/null; then
        echo "$host is reachable."
    else
        echo "$host is NOT reachable."
    fi
    echo
done
