#!/usr/bin/env bash
# Image - Stale Images Report (from image-staleness-report.sh)
IMAGE_STALE_DAYS="${IMAGE_STALE_DAYS:-30}"; IMAGE_STALE_WARN="${IMAGE_STALE_WARN:-5}"; command -v docker >/dev/null 2>&1 || { echo "Docker not installed"; exit 0; }
NOW=$(date +%s); STALE=(); DANGLING=()
docker images --format '{{.Repository}}:{{.Tag}} {{.CreatedAt}}' | while read -r LINE; do NAME=$(echo "$LINE" | awk '{print $1}'); DATE_STR=$(echo "$LINE" | cut -d' ' -f2-); EPOCH=$(date -d "$DATE_STR" +%s 2>/dev/null || echo "$NOW"); AGE=$(((NOW - EPOCH)/86400)); [ "$AGE" -ge "$IMAGE_STALE_DAYS" ] && STALE+=("$NAME(${AGE}d)"); done
while read -r ID; do DANGLING+=("$ID"); done < <(docker images -f dangling=true -q)
SC=${#STALE[@]}; DC=${#DANGLING[@]}; MSG="Stale=$SC warn>${IMAGE_STALE_WARN} list=[${STALE[*]}] dangling=$DC"
if [ "$SC" -gt "$IMAGE_STALE_WARN" ]; then echo "ALERT: stale $SC > $IMAGE_STALE_WARN | $MSG"; exit 1; fi
echo "$MSG"; exit 0