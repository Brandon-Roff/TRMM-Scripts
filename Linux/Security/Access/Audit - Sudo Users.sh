#!/usr/bin/env bash
# Audit - Sudo Users (from Audit Users with sudo.sh)
if [ $EUID -ne 0 ]; then echo "Run as root"; exit 1; fi
echo "Sudo-capable accounts (UID 0 or in sudo group):";
awk -F: '$3 == 0 {print $1}' /etc/passwd
getent group sudo | awk -F: '{print $4}' | tr ',' '\n' | sort -u
exit 0