#!/bin/bash
# Simple port scan using ss for localhost or nmap for remote hosts
TARGET="${1:-localhost}"
echo "Open ports on $TARGET:"
if [ "$TARGET" = "localhost" ] || [ "$TARGET" = "127.0.0.1" ]; then
    ss -tuln
else
    if command -v nmap &> /dev/null; then
        nmap -Pn "$TARGET"
    else
        echo "nmap not installed. Please install nmap for remote scans."
    fi
fi
