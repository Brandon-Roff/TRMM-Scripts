#!/bin/bash

# Check if Wazuh agent is installed
if ! dpkg -l | grep wazuh-agent > /dev/null; then
    echo "Wazuh agent is not installed on this system."
    exit 1


fi

# Extract version information
wazuh_version=$(dpkg -l | grep wazuh-agent | awk '{print $3}')

echo "$wazuh_version"