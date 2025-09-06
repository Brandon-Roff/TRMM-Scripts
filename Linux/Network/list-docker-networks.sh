#!/bin/bash


if ! command -v docker &> /dev/null; then
    echo "Docker is not installed or not in PATH."
    exit 1
fi

echo "Listing all Docker networks:"
docker network ls

echo
for net in $(docker network ls --format '{{.Name}}'); do
    echo "---"
    echo "Details for network: $net"
    docker network inspect "$net"
    echo
done
