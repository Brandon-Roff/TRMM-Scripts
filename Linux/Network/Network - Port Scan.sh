#!/usr/bin/env bash
# Network - Port Scan (from port-scan.sh)
TARGET="${1:-localhost}"; echo "Scanning $TARGET";
if [ "$TARGET" = "localhost" ] || [ "$TARGET" = "127.0.0.1" ]; then ss -tuln; else if command -v nmap >/dev/null 2>&1; then nmap -Pn "$TARGET"; else echo "Install nmap for remote scans"; fi; fi
exit 0