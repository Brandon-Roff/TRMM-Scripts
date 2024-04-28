#!/bin/bash

# Check if unattended-upgrades package is installed
if dpkg -s unattended-upgrades &> /dev/null; then
    echo "unattended-upgrades is installed."
    exit 0
else
    # Install if not found
    echo "unattended-upgrades is not installed. Installing unattended-upgrades package."
    sudo apt-get install unattended-upgrades -y
    # Check if installation was successful
    if dpkg -s unattended-upgrades &> /dev/null; then
        echo "unattended-upgrades is installed."
        exit 0
    else
        echo "unattended-upgrades could not be installed so needs Manual intervention ."
        exit 10
    fi
fi