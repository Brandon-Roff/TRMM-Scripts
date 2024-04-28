#!/bin/bash

# Check if Nala is installed

if command -v nala &> /dev/null
then
    echo "Nala is installed"
    exit 0
else
# Install Nala

    echo "Installing Nala"
    sudo apt-get install nala -y >> /dev/null
    
    if command -v nala &> /dev/null
    then
        echo "Nala is Now Installed installed"
        exit 66
    else
        echo "Nala is not able to be installed"
        exit 1
    fi
    
fi