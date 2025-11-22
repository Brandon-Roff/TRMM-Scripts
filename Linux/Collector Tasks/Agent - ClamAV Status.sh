#!/usr/bin/env bash
# Agent - ClamAV Status (from ClamAV Check.sh)
if systemctl is-active --quiet clamav-daemon; then echo "ClamAV running"; exit 0; else echo "ClamAV not running"; exit 1; fi