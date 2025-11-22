#!/usr/bin/env bash
# Check - DNS Resolution Latency (from dns-resolution-latency.sh)
HOSTS_RAW="${HOSTS:-google.com cloudflare.com github.com}"; WARN="${DNS_LATENCY_WARN:-300}"; HOSTS_LIST=$(echo "$HOSTS_RAW" | tr ',' ' ')
ALERTS=(); RESULTS=()
for H in $HOSTS_LIST; do START=$(date +%s%3N); if getent hosts "$H" >/dev/null 2>&1; then END=$(date +%s%3N); LAT=$((END-START)); RESULTS+=("$H:$LAT"); [ "$LAT" -ge "$WARN" ] && ALERTS+=("$H $LAT ms >= $WARN") ; else RESULTS+=("$H:unresolved"); ALERTS+=("$H unresolved"); fi; done
MSG="DNS results: ${RESULTS[*]} warn>=$WARN"; if [ ${#ALERTS[@]} -gt 0 ]; then echo "ALERT: ${ALERTS[*]} | $MSG"; exit 1; fi; echo "$MSG"; exit 0