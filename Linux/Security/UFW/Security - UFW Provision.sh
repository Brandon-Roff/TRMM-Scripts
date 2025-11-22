#!/usr/bin/env bash
# Security - UFW Provision (from UFW_ Install and Prevision firewall.sh)
command -v ufw >/dev/null 2>&1 || apt-get install -y ufw
ufw status | grep -q inactive && ufw --force enable
PORTS="ssh http https 445 21 53"
for p in $PORTS; do ufw status | grep -qw "$p" || ufw allow "$p"; done
echo "UFW provisioning complete."; exit 0