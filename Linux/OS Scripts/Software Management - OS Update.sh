#!/usr/bin/env bash
# Software Management - OS Update (from Update.sh)
if command -v nala >/dev/null 2>&1; then nala update -y && nala upgrade -y && nala autoremove -y; echo "Updated via Nala"; else apt-get update -y && apt-get upgrade -y && apt autoremove -y; echo "Updated via apt"; fi
exit 0