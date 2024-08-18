#!/bin/bash

# Get the CPU usage percentage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Alert if CPU usage is over 85%
if (( $(echo "$cpu_usage > 85" | bc -l) )); then
    echo "ALERT: CPU usage is over 85%! Current usage: $cpu_usage%"
    exit 1
fi

# Exit with code 2 if CPU usage is over 65%
if (( $(echo "$cpu_usage > 65" | bc -l) )); then
    echo "WARNING: CPU usage is over 65%! Exiting with code 2. Current usage: $cpu_usage%"
    exit 2
fi

# Exit with code 0 if CPU usage is normal
echo "CPU usage is normal. Current usage: $cpu_usage%"
exit 0
