#!/usr/bin/env bash
# Agent - Wazuh Update (from Wazuh - Linux Update.sh)
[ -z "$WA_VERSION" ] && echo "Set WA_VERSION env (e.g. 4.8.0-1)" && exit 1
ARCH=$(uname -m); case $ARCH in x86_64) ARCH="amd64";; aarch64) ARCH="arm64";; armv7l) ARCH="armhf";; *) echo "Unsupported architecture"; exit 1;; esac
systemctl stop wazuh-agent
URL="https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_${WA_VERSION}_${ARCH}.deb"
wget -q "$URL" -O /tmp/wazuh-update.deb && dpkg -i /tmp/wazuh-update.deb && systemctl daemon-reload && systemctl enable wazuh-agent && systemctl start wazuh-agent && echo "Wazuh updated" || { echo "Update failed"; exit 1; }
exit 0