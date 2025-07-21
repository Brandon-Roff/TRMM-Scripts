#!/bin/bash

# Colors (if terminal)
if [ -t 1 ]; then
  BLUE="\033[1;34m"
  GREEN="\033[0;32m"
  CYAN="\033[0;36m"
  YELLOW="\033[1;33m"
  RESET="\033[0m"
else
  BLUE=; GREEN=; CYAN=; YELLOW=; RESET=
fi

echo -e "\n${BLUE}=== Docker Services (Host & Internal Ports) ===${RESET}\n"
printf "${YELLOW}%-20s %-25s %-25s${RESET}\n" "CONTAINER" "HOST PORTS (proto)" "INTERNAL PORTS (proto)"
printf "${YELLOW}%-20s %-25s %-25s${RESET}\n" "--------------------" "-------------------------" "-------------------------"

docker ps --format "{{.Names}}|{{.Ports}}" | while IFS='|' read -r name ports; do
  # Extract unique host ports with proto (like 8000/tcp)
  host_ports=$(echo "$ports" | grep -oP '(?<=0\.0\.0\.0:|:::)[0-9]+->.*?/(tcp|udp)' | \
    sed -E 's/([0-9]+)->.*\/(tcp|udp)/\1\/\2/' | sort -u | paste -sd',' -)
  [[ -z "$host_ports" ]] && host_ports="None"

  # Extract unique internal container ports (like 8000/tcp)
  internal_ports=$(echo "$ports" | grep -oP '(?<=->)[0-9]+/(tcp|udp)' | sort -u | paste -sd',' -)
  [[ -z "$internal_ports" ]] && internal_ports="None"

  printf "${BLUE}%-20s${RESET} ${GREEN}%-25s${RESET} ${CYAN}%-25s${RESET}\n" "$name" "$host_ports" "$internal_ports"
done

echo
