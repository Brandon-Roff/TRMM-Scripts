#!/bin/sh
# Monitor - Process Snapshot (from Process Monitor.sh)
echo "Top CPU Processes"; ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head
echo "Top Memory Processes"; ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
exit 0