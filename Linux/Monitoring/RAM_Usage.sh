#!/bin/bash

# Get the total and used RAM
total_ram=$(free -m | awk '/^Mem:/ {print $2}')
used_ram=$(free -m | awk '/^Mem:/ {print $3}')

# Calculate the RAM usage percentage
ram_usage=$(echo "scale=2; $used_ram/$total_ram*100" | bc)

# Alert if RAM usage is over 85%
if (( $(echo "$ram_usage > 85" | bc -l) )); then
    echo "ALERT: RAM usage is over 85%! Current usage: $ram_usage%"
    exit 1
fi

# Exit with code 2 if RAM usage is over 65%
if (( $(echo "$ram_usage > 65" | bc -l) )); then
    echo "WARNING: RAM usage is over 65%! Exiting with code 2. Current usage: $ram_usage%"
    exit 2
fi

# Exit with code 0 if RAM usage is normal
echo "RAM usage is normal. Current usage: $ram_usage%"
exit 0
