#!/bin/bash
# Monitor - Swap Usage (from Check - SwapSpace.sh)
USED=$(free | awk '/Swap/ {print $3}'); TOTAL=$(free | awk '/Swap/ {print $2}'); if [ "$TOTAL" -gt 0 ]; then P=$((100*USED/TOTAL)); [ "$P" -gt 50 ] && echo "Swap high ${P}%"; echo "Swap ${P}% used"; fi
exit 0