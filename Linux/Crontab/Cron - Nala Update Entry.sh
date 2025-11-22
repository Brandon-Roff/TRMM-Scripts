#!/usr/bin/env bash
# Cron - Nala Update Entry (from Check Nala Update Crontab.sh)
if [ ! -x "$(command -v nala)" ]; then echo "Nala not installed"; exit 1; fi
if crontab -l | grep -q "nala upgrade -y"; then echo "Nala update scheduled"; exit 0; else (crontab -l 2>/dev/null; echo "0 2 * * 0 $(command -v nala) upgrade -y") | crontab -; echo "Nala update scheduled (added)"; exit 2; fi