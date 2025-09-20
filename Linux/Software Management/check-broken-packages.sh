#!/bin/bash
# Check for broken or partially installed packages
if ! command -v apt &> /dev/null; then
  echo "This script requires apt."
  exit 1
fi
sudo apt-get check
sudo dpkg --audit
