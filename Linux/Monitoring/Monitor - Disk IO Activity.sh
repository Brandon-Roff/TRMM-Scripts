#!/bin/sh
# Monitor - Disk IO Activity (from Disk IO Activity.sh)
if [ "$(id -u)" != "0" ]; then echo "Must run as root"; exit 1; fi
command -v iostat >/dev/null 2>&1 || apt-get install -y sysstat
if command -v iostat >/dev/null 2>&1; then
  echo "Disk I/O Activity:"; iostat -d 1
  exit 0
else
  echo "iostat missing"; exit 1
fi