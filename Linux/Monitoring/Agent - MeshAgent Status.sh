#!/bin/bash
# Agent - MeshAgent Status (from Check - MeshAgent_is_running.sh)
SERVICE="meshagent.service"
if [ "$(systemctl is-active $SERVICE)" = "active" ]; then echo "Mesh Agent Running"; exit 0; else echo "Mesh Agent NOT running"; systemctl start $SERVICE; if [ "$(systemctl is-active $SERVICE)" = "active" ]; then echo "Mesh Agent started"; exit 2; else echo "Mesh Agent failed to start"; exit 1; fi; fi