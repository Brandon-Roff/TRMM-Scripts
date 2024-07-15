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
            print "Begining the update for a x86_64 (32-Bit) client..."
            wget -O /opt/rmmagent-linux.sh https://raw.githubusercontent.com/netvolt/LinuxRMM-Script/main/rmmagent-linux.sh  | bash /opt/rmmagent-linux.sh update $ARCH
        fi
# ARM 64
    elif [ "$ARCH" = "aarch64" ]; then
        ARCH="arm64"
        # Download Linux RMM Script if not already exists
        if [ ! -f /opt/rmmagent-linux.sh ]; then
            print "Begining the update for a ARM 64-Bit client..."
            wget -O /opt/rmmagent-linux.sh https://raw.githubusercontent.com/netvolt/LinuxRMM-Script/main/rmmagent-linux.sh | bash /opt/rmmagent-linux.sh update $ARCH
        fi       

# Raspberry Pi 3 and 4
    elif [ "$ARCH" = "armv7l" ]; then
        ARCH="armv6"
        # Download Linux RMM Script if not already exists
        if [ ! -f /opt/rmmagent-linux.sh ]; then
            print "Begining the update for an ARM 32-bit Client..."
            wget -O /opt/rmmagent-linux.sh https://raw.githubusercontent.com/netvolt/LinuxRMM-Script/main/rmmagent-linux.sh | bash /opt/rmmagent-linux.sh update $ARCH
        fi

    else
        echo "Unsupported architecture"
        exit 1
    fi