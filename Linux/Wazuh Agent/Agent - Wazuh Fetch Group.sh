#!/usr/bin/env bash
# Agent - Wazuh Fetch Group (from Wazuh - Fetch Agent Group [LIN].sh)
CFG="/var/ossec/etc/ossec.conf"; [ -f "$CFG" ] || { echo "Missing ossec.conf"; exit 1; }
sed -n 's:.*<groups>\(.*\)</groups>.*:\1:p' "$CFG" | tr ',' '\n'; exit 0