#!/usr/bin/env bash
# Audit - Docker Exposure (from Security_ Docker Audit [LIN].sh)
echo "Docker container port exposure summary:";
docker ps --format '{{.Names}}|{{.Ports}}' 2>/dev/null | while IFS='|' read -r name ports; do
  host_ports=$(echo "$ports" | grep -oP '(?<=0\.0\.0\.0:|:::)[0-9]+->.*?/(tcp|udp)' | sed -E 's/([0-9]+)->.*\/(tcp|udp)/\1\/\2/' | sort -u | paste -sd',' -)
  [[ -z "$host_ports" ]] && host_ports="None"
  echo "$name: $host_ports"
done
exit 0