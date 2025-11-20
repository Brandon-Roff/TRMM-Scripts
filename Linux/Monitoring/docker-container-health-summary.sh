#!/usr/bin/env bash
# docker-container-health-summary.sh - Summarize Docker container health & restarts.
# Env Vars:
#   UNHEALTHY_WARN (default 1) - alert if unhealthy container count exceeds
#   RESTART_WARN (default 5) - alert if any container restart count exceeds
#   GOTIFY_URL / GOTIFY_TOKEN for alerting
# Exit codes: 0 normal, 1 threshold exceeded or Docker unavailable
set -euo pipefail
UNHEALTHY_WARN="${UNHEALTHY_WARN:-1}"
RESTART_WARN="${RESTART_WARN:-5}"

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not installed"; exit 0
fi

MAP=$(docker ps --format '{{.ID}} {{.Names}}') || { echo "Failed to list containers"; exit 1; }
UNHEALTHY=0
ALERTS=()
DETAILS=()
while read -r ID NAME; do
  [ -z "$ID" ] && continue
  INSPECT=$(docker inspect "$ID" 2>/dev/null) || continue
  HEALTH=$(echo "$INSPECT" | jq -r '.[0].State.Health.Status' 2>/dev/null || echo "none")
  RESTARTS=$(echo "$INSPECT" | jq -r '.[0].RestartCount' 2>/dev/null || echo 0)
  DETAILS+=("$NAME:health=$HEALTH,restarts=$RESTARTS")
  if [ "$HEALTH" = "unhealthy" ]; then
    UNHEALTHY=$((UNHEALTHY+1))
  fi
  if [ "$RESTARTS" -ge "$RESTART_WARN" ]; then
    ALERTS+=("$NAME high restarts $RESTARTS >= $RESTART_WARN")
  fi
done <<< "$MAP"

if [ "$UNHEALTHY" -ge "$UNHEALTHY_WARN" ]; then
  ALERTS+=("Unhealthy containers: $UNHEALTHY >= $UNHEALTHY_WARN")
fi

MSG="Docker summary: ${DETAILS[*]} | Unhealthy:$UNHEALTHY (warn>${UNHEALTHY_WARN})"
if [ ${#ALERTS[@]} -gt 0 ]; then
  ALERT_MSG="Container alerts: ${ALERTS[*]} | $MSG"
  if [ -n "${GOTIFY_URL:-}" ] && [ -n "${GOTIFY_TOKEN:-}" ]; then
    curl -s -X POST "${GOTIFY_URL}/message?token=${GOTIFY_TOKEN}" -F "title=Docker Health" -F "message=${ALERT_MSG}" -F "priority=5" >/dev/null || true
  fi
  echo "$ALERT_MSG"; exit 1
fi

echo "$MSG"; exit 0
