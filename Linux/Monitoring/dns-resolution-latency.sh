#!/usr/bin/env bash
# dns-resolution-latency.sh - Measure DNS resolution latency for a set of hostnames.
# Env Vars:
#   HOSTS (space/comma separated hostnames) default: "google.com cloudflare.com github.com"
#   DNS_LATENCY_WARN (ms) default: 300
#   GOTIFY_URL / GOTIFY_TOKEN for alerting
# Exit codes: 0 normal, 1 any host exceeds latency threshold or unreachable
set -euo pipefail
HOSTS_RAW="${HOSTS:-google.com cloudflare.com github.com}"
DNS_LATENCY_WARN="${DNS_LATENCY_WARN:-300}"
# Normalize separators
HOSTS_LIST=$(echo "$HOSTS_RAW" | tr ',' ' ')

ALERTS=()
RESULTS=()
for H in $HOSTS_LIST; do
  START=$(date +%s%3N)
  if getent hosts "$H" >/dev/null 2>&1; then
    END=$(date +%s%3N)
    LAT=$((END-START))
    RESULTS+=("$H:$LAT")
    if [ "$LAT" -ge "$DNS_LATENCY_WARN" ]; then
      ALERTS+=("$H latency $LAT ms >= $DNS_LATENCY_WARN ms")
    fi
  else
    RESULTS+=("$H:unresolved")
    ALERTS+=("$H unresolved")
  fi
done

MSG="DNS latency results: ${RESULTS[*]} (warn >= ${DNS_LATENCY_WARN}ms)"
if [ ${#ALERTS[@]} -gt 0 ]; then
  MSG="DNS latency ALERTS: ${ALERTS[*]} | ${MSG}"
  if [ -n "${GOTIFY_URL:-}" ] && [ -n "${GOTIFY_TOKEN:-}" ]; then
    curl -s -X POST "${GOTIFY_URL}/message?token=${GOTIFY_TOKEN}" -F "title=DNS Latency" -F "message=${MSG}" -F "priority=5" >/dev/null || true
  fi
  echo "$MSG"; exit 1
else
  echo "$MSG"; exit 0
fi
