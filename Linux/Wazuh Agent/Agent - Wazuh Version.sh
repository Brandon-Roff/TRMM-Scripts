#!/usr/bin/env bash
# Agent - Wazuh Version (from Wazuh Agent Version.sh)
dpkg -l | awk '/wazuh-agent/ {print $3}' || { echo "Not installed"; exit 1; }
exit 0