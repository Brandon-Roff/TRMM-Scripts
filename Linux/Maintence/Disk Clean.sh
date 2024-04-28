#!/bin/bash

# Clean package cache
sudo apt clean

# Remove old versions of installed packages
sudo apt autoremove --purge

# Clear apt cache
sudo rm -rf /var/cache/apt/archives/*.deb

# Clear thumbnail cache
rm -rf ~/.cache/thumbnails/*

# Clean up temporary files
sudo rm -rf /tmp/*

# Remove old log files
sudo find /var/log -type f -name "*.log" -delete

# Remove old journal files
sudo journalctl --vacuum-time=7d

echo "Disk space cleaned up successfully."