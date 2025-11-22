#!/bin/bash
# Monitor - CPU Usage
# Reports CPU usage percentage and exits with alert codes.
# (Derived from original CPU_Usage.sh)
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
if (( $(echo "$cpu_usage > 85" | bc -l) )); then
  echo "ALERT: CPU usage >85% ($cpu_usage%)"; exit 1
fi
if (( $(echo "$cpu_usage > 65" | bc -l) )); then
  echo "WARNING: CPU usage >65% ($cpu_usage%)"; exit 2
fi
echo "CPU usage normal: $cpu_usage%"; exit 0