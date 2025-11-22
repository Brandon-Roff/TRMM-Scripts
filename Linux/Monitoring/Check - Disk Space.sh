#!/bin/bash
# Check - Disk Space (from Check - DiskSpace.sh)
THRESHOLD=${THRESHOLD:-80}
df -h | grep '^/dev/' | while read line; do USAGE=$(echo $line | awk '{print $5}' | tr -d '%'); MOUNT=$(echo $line | awk '{print $6}'); if [ "$USAGE" -ge "$THRESHOLD" ]; then echo "WARNING: $MOUNT at ${USAGE}%"; fi; done
exit 0