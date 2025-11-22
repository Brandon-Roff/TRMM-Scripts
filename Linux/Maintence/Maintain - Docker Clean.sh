#!/usr/bin/env bash
# Maintain - Docker Clean (from Docker-Clean.sh)
command -v docker >/dev/null 2>&1 || { echo "Docker not installed"; exit 0; }
docker container prune -f --filter "status=exited" >/dev/null 2>&1
docker image prune -f --filter "dangling=true" >/dev/null 2>&1
docker volume prune -f --filter "dangling=true" >/dev/null 2>&1
docker network prune -f --filter "dangling=true" >/dev/null 2>&1
echo "Docker cleanup done."; exit 0