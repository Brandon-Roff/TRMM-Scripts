#!/usr/bin/env bash
# Audit - Users Overview (from Security_ Audit Users [LIN].sh)
echo "=== Users Overview ==="
awk -F: '{print $1":"$3":"$6}' /etc/passwd
exit 0