#!/usr/bin/env bash
# Monitor - Docker Container Health (from docker-container-health-summary.sh)
UNHEALTHY_WARN="${UNHEALTHY_WARN:-1}"; RESTART_WARN="${RESTART_WARN:-5}"; command -v docker >/dev/null 2>&1 || { echo "Docker not installed"; exit 0; }
MAP=$(docker ps --format '{{.ID}} {{.Names}}'); UNH=0; ALERTS=(); DETAILS=()
while read -r ID NAME; do [ -z "$ID" ] && continue; J=$(docker inspect "$ID" 2>/dev/null) || continue; H=$(echo "$J" | jq -r '.[0].State.Health.Status' 2>/dev/null || echo none); R=$(echo "$J" | jq -r '.[0].RestartCount' 2>/dev/null || echo 0); DETAILS+=("$NAME:h=$H,r=$R"); [ "$H" = "unhealthy" ] && UNH=$((UNH+1)); [ "$R" -ge "$RESTART_WARN" ] && ALERTS+=("$NAME restarts $R >= $RESTART_WARN"); done <<< "$MAP"
[ "$UNH" -ge "$UNHEALTHY_WARN" ] && ALERTS+=("Unhealthy $UNH >= $UNHEALTHY_WARN")
MSG="Docker: ${DETAILS[*]} Unhealthy=$UNH"; if [ ${#ALERTS[@]} -gt 0 ]; then echo "ALERT: ${ALERTS[*]} | $MSG"; exit 1; fi; echo "$MSG"; exit 0