#!/usr/bin/env bash
# Maintain - Disk Clean (from Disk Clean.sh)
apt clean 2>/dev/null || true
apt autoremove --purge -y 2>/dev/null || true
rm -rf ~/.cache/thumbnails/* 2>/dev/null || true
rm -rf /tmp/* 2>/dev/null || true
journalctl --vacuum-time=7d 2>/dev/null || true
echo "Disk cleanup completed."; exit 0