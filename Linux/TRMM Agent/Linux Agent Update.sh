#!/bin/sh

#  TRMM Agent Update Script
#  This script will update the TRMM agent to the latest version
# Credit: Netvolt,
#check cpu architecture
ARCH=$(uname -m)

# x86 64
if [ "$ARCH" = "x86_64" ]; then
        ARCH="amd64" 
        # Download Linux RMM Script if not already exists
        if [ ! -f /opt/rmmagent-linux.sh ]; then
            wget -O /opt/rmmagent-linux.sh https://raw.githubusercontent.com/netvolt/LinuxRMM-Script/main/rmmagent-linux.sh
        fi
        #run the update script
        bash /opt/rmmagent-linux.sh update $ARCH

# ARM 64
    elif [ "$ARCH" = "aarch64" ]; then
        ARCH="arm64"
        # Download Linux RMM Script if not already exists
        if [ ! -f /opt/rmmagent-linux.sh ]; then
            wget -O /opt/rmmagent-linux.sh https://raw.githubusercontent.com/netvolt/LinuxRMM-Script/main/rmmagent-linux.sh
        fi
        #run the update script
        bash /opt/rmmagent-linux.sh update $ARCH        

# Raspberry Pi 3 and 4
    elif [ "$ARCH" = "armv7l" ]; then
        ARCH="armv6"
        # Download Linux RMM Script if not already exists
        if [ ! -f /opt/rmmagent-linux.sh ]; then
            wget -O /opt/rmmagent-linux.sh https://raw.githubusercontent.com/netvolt/LinuxRMM-Script/main/rmmagent-linux.sh
        fi
        #run the update script
        bash /opt/rmmagent-linux.sh update $ARCH

    else
        echo "Unsupported architecture"
        exit 1
    fi