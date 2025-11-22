#!/usr/bin/env bash
# Check - SSH Service (from Check SSH is Running.sh)
if systemctl is-active --quiet ssh || systemctl is-active --quiet sshd; then echo "SSH service running"; exit 0; else echo "SSH service NOT running"; exit 1; fi