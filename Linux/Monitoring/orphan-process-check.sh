#!/usr/bin/env bash
# orphan-process-check.sh - Detect orphaned and zombie processes
# Env Vars:
#   ORPHAN_WARN (default 5) - alert if orphan processes (PPID=1) exceed
#   ZOMBIE_WARN (default 1) - alert if zombie processes exceed
#   GOTIFY_URL / GOTIFY_TOKEN - optional Gotify alert
# Exit codes: 0 normal, 1 any threshold exceeded
set -euo pipefail
ORPHAN_WARN="${ORPHAN_WARN:-5}"
ZOMBIE_WARN="${ZOMBIE_WARN:-1}"

# Orphans: parent PID 1 but not kernel threads
ORPHANS=$(ps -eo ppid=,pid=,stat= | awk '$1==1 {print $2" "$3}' | wc -l)
# Zombies: STAT contains Z
ZOMBIES=$(ps -eo stat= | grep -c 'Z' || true)

MSG="Orphans:$ORPHANS (warn>${ORPHAN_WARN}) Zombies:$ZOMBIES (warn>${ZOMBIE_WARN})"
ALERT_COND=false
[ "$ORPHANS" -gt "$ORPHAN_WARN" ] && ALERT_COND=true && ALERT_MSG="High orphan count: $ORPHANS > $ORPHAN_WARN"
[ "$ZOMBIES" -gt "$ZOMBIE_WARN" ] && ALERT_COND=true && ALERT_MSG="${ALERT_MSG:-} High zombie count: $ZOMBIES > $ZOMBIE_WARN"

if $ALERT_COND; then
  if [ -n "${GOTIFY_URL:-}" ] && [ -n "${GOTIFY_TOKEN:-}" ]; then
    curl -s -X POST "${GOTIFY_URL}/message?token=${GOTIFY_TOKEN}" -F "title=Process Health" -F "message=${ALERT_MSG}" -F "priority=5" >/dev/null || true
  fi
  echo "$ALERT_MSG | $MSG"; exit 1
fi

echo "$MSG"; exit 0
