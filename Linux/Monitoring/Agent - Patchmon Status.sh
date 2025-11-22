#!/bin/bash
# Agent - Patchmon Status (from Check - Patchmon Agent is installed.sh)
INSTALLED=false; command -v patchmon-agent &>/dev/null && INSTALLED=true
ACTIVE=false; systemctl is-active --quiet patchmon-agent && ACTIVE=true
if $INSTALLED && $ACTIVE; then echo "Patchmon installed & running"; exit 0; fi
if ! $INSTALLED && ! $ACTIVE; then echo "Patchmon not installed & not running"; exit 1; fi
echo "Patchmon installed state=$INSTALLED active state=$ACTIVE"; exit 2