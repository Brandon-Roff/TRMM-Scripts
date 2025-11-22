#!/usr/bin/env bash
# Agent - Wazuh Install (from Wazuh - Linux Install.sh)
ARCH=$(uname -m); case $ARCH in x86_64) ARCH="amd64";; aarch64) ARCH="arm64";; armv7l) ARCH="armhf";; *) echo "Unsupported architecture"; exit 1;; esac
[ -z "$WAZUH_MANAGER" ] && echo "Set WAZUH_MANAGER env" && exit 1
URL="https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.8.2-2_${ARCH}.deb"
wget -q "$URL" -O /tmp/wazuh.deb && WAZUH_MANAGER="$WAZUH_MANAGER" dpkg -i /tmp/wazuh.deb && systemctl daemon-reload && systemctl enable wazuh-agent && systemctl start wazuh-agent && echo "Wazuh installed" || { echo "Install failed"; exit 1; }
exit 0