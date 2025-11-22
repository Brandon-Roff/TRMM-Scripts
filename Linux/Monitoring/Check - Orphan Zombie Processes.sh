#!/usr/bin/env bash
# Check - Orphan Zombie Processes (from orphan-process-check.sh)
ORPHAN_WARN="${ORPHAN_WARN:-5}"; ZOMBIE_WARN="${ZOMBIE_WARN:-1}"; ORPHANS=$(ps -eo ppid=,pid=,stat= | awk '$1==1 {print $2}' | wc -l); ZOMBIES=$(ps -eo stat= | grep -c 'Z' || true)
if [ "$ORPHANS" -gt "$ORPHAN_WARN" ] || [ "$ZOMBIES" -gt "$ZOMBIE_WARN" ]; then echo "ALERT: orphans=$ORPHANS (>$ORPHAN_WARN) zombies=$ZOMBIES (>$ZOMBIE_WARN)"; exit 1; fi
echo "Process health OK. orphans=$ORPHANS zombies=$ZOMBIES"; exit 0