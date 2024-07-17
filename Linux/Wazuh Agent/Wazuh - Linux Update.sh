#!/bin/sh

# Wazuh Agent Update Script
# The ENV Vairable to Specify is WA_Version=''
# At time of this its "4.8.0-1"

#check cpu architecture
ARCH=$(uname -m)

# Install On Ubuntu 18.04, 20.04, 20.10, 21.04, 21.10, 22.04 and Debian 10, 11, 12 
if [ "$ARCH" = "x86_64" ]; then
        ARCH="amd64" 
        # Download and install the Wazuh agent package
        wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_"$WA_Version"_amd64.deb &&  dpkg -i ./wazuh-agent_"$WA_Version"_amd64.deb
        # Enable and start the Wazuh agent service
        sudo systemctl daemon-reload
        sudo systemctl enable wazuh-agent
        sudo systemctl start wazuh-agent
    elif [ "$ARCH" = "aarch64" ]; then
        ARCH="arm64"
        # Download and install the Wazuh agent package
        wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_"$WA_Version"_arm64.deb &&  dpkg -i ./wazuh-agent_"$WA_Version"_arm64.deb
        # Enable and start the Wazuh agent service
        sudo systemctl daemon-reload
        sudo systemctl enable wazuh-agent
        sudo systemctl start wazuh-agent
    elif [ "$ARCH" = "armv7l" ]; then
        ARCH="armhf"
        # Download and install the Wazuh agent package
        wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_"$WA_Version"_armhf.deb &&  dpkg -i ./wazuh-agent_"$WA_Version"_armhf.deb
        # Enable and start the Wazuh agent service
        sudo systemctl daemon-reload
        sudo systemctl enable wazuh-agent
        sudo systemctl start wazuh-agent
    else
        echo "Unsupported architecture"
        exit 1
    fi