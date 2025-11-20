#!/usr/bin/env bash
# image-staleness-report.sh - Report stale docker images and unused dangling images.
# Env Vars:
#   IMAGE_STALE_DAYS (default 30) - consider images older than this as stale
#   IMAGE_STALE_WARN (default 5) - alert if stale image count exceeds
#   GOTIFY_URL / GOTIFY_TOKEN for alerting
# Exit codes: 0 normal, 1 threshold exceeded or docker unavailable
set -euo pipefail
IMAGE_STALE_DAYS="${IMAGE_STALE_DAYS:-30}"
IMAGE_STALE_WARN="${IMAGE_STALE_WARN:-5}"

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not installed"; exit 0
fi

NOW=$(date +%s)
STALE=()
DANGLING=()

# Get images with created date
docker images --format '{{.Repository}}:{{.Tag}} {{.CreatedAt}}' | while read -r LINE; do
  NAME=$(echo "$LINE" | awk '{print $1}')
  DATE_STR=$(echo "$LINE" | cut -d' ' -f2-)
  # Convert to epoch
  EPOCH=$(date -d "$DATE_STR" +%s 2>/dev/null || echo "$NOW")
  AGE_DAYS=$(((NOW - EPOCH)/86400))
  if [ "$AGE_DAYS" -ge "$IMAGE_STALE_DAYS" ]; then
    STALE+=("$NAME(${AGE_DAYS}d)")
  fi
done

# Dangling images
while read -r ID; do
  DANGLING+=("$ID")
done < <(docker images -f dangling=true -q)

STALE_COUNT=${#STALE[@]}
DANGLING_COUNT=${#DANGLING[@]}
MSG="Image staleness: stale=${STALE_COUNT} (warn>${IMAGE_STALE_WARN}) list=[${STALE[*]}] dangling=${DANGLING_COUNT}"

if [ "$STALE_COUNT" -gt "$IMAGE_STALE_WARN" ]; then
  ALERT_MSG="Stale image count $STALE_COUNT > $IMAGE_STALE_WARN | $MSG"
  if [ -n "${GOTIFY_URL:-}" ] && [ -n "${GOTIFY_TOKEN:-}" ]; then
    curl -s -X POST "${GOTIFY_URL}/message?token=${GOTIFY_TOKEN}" -F "title=Docker Image Stale" -F "message=${ALERT_MSG}" -F "priority=4" >/dev/null || true
  fi
  echo "$ALERT_MSG"; exit 1
fi

echo "$MSG"; exit 0
