#!/bin/bash

# Check if ClamAV is installed
if command -v clamscan &> /dev/null
then
    echo "ClamAV is already installed."
else
    # Install ClamAV
    echo "ClamAV is not installed. Installing..."
    sudo apt update -y
    sudo apt install -y clamav

    echo "ClamAV has been successfully installed."
fi