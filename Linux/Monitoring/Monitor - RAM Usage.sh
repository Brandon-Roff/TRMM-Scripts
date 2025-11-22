#!/bin/bash
# Monitor - RAM Usage (from RAM_Usage.sh)
total_ram=$(free -m | awk '/^Mem:/ {print $2}')
used_ram=$(free -m | awk '/^Mem:/ {print $3}')
ram_usage=$(echo "scale=2; $used_ram/$total_ram*100" | bc)
if (( $(echo "$ram_usage > 85" | bc -l) )); then
  echo "ALERT: RAM usage >85% ($ram_usage%)"; exit 1
fi
if (( $(echo "$ram_usage > 65" | bc -l) )); then
  echo "WARNING: RAM usage >65% ($ram_usage%)"; exit 2
fi
echo "RAM usage normal: $ram_usage%"; exit 0