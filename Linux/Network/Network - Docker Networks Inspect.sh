#!/usr/bin/env bash
# Network - Docker Networks Inspect (from list-docker-networks.sh)
command -v docker >/dev/null 2>&1 || { echo "Docker not installed"; exit 1; }
echo "Docker networks:"; docker network ls
for net in $(docker network ls --format '{{.Name}}'); do echo "--- $net"; docker network inspect "$net"; done
exit 0