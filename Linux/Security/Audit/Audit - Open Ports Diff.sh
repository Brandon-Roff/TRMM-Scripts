#!/usr/bin/env bash
# Audit - Open Ports Diff (from Security_ Port Audit [LIN].sh)
KNOWN="/var/log/known_ports.txt"; CUR=$(ss -tuln | awk '/LISTEN/ {print $5}' | grep -oE '[0-9]+$' | sort -n | uniq)
if [ ! -f "$KNOWN" ]; then echo "$CUR" > "$KNOWN"; echo "Baseline created."; exit 0; fi
NEW=$(comm -13 <(cat "$KNOWN") <(echo "$CUR"))
if [ -n "$NEW" ]; then echo "New ports: $NEW"; echo "$CUR" > "$KNOWN"; exit 1; fi
echo "No new ports."; exit 0