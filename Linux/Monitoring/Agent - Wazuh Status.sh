#!/bin/bash
# Agent - Wazuh Status (from Check - Wazuh_is_running.sh)
SERVICE="wazuh-agent.service"
if [ "$(systemctl is-active $SERVICE)" = "active" ]; then echo "Wazuh Agent Running"; exit 0; else echo "Wazuh Agent NOT running"; systemctl start $SERVICE; if [ "$(systemctl is-active $SERVICE)" = "active" ]; then echo "Wazuh Agent started"; exit 2; else echo "Wazuh Agent failed to start"; exit 1; fi; fi