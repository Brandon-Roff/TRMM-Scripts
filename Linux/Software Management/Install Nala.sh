#!/bin/sh

#need to replace as Nala project has been archived

# Update package list
sudo apt-get update -y

# Install nala package
if sudo apt-get install nala -y; then
    # Check if nala is installed
    if command -v nala > /dev/null; then
        echo "Nala is now installed"
    else
        echo "Nala installation completed but the executable is not found" >&2
        exit 1
    fi
else
    echo "Failed to install Nala may neeed to install it manually" >&2
    exit 1
fi