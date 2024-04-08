#!/bin/sh

#check if nala is installed  and use it for updates
if [ -x "$(command -v nala)" ]; then
    echo "Nala is installed"
    echo . 
    echo "Will use this for updates..."
    echo .
    sudo nala update -y >> /tmp/update.log
    sudo nala upgrade -y >> /tmp/upgrade.log
    sudo nala autoremove -y /tmp/clean.log
    echo OS updated successfully using Nala
    exit 0
else
# Resualt to using basic apt package as nala dosent exist
    echo "Nala is not installed"
    echo "Will Resualt to using basic apt package"
    echo .
    # Start Package update using apt 
    sudo apt-get update -y >> /tmp/update.log
    # Start Package upgrade
    sudo apt-get upgrade -y >> /tmp/upgrade.log
    # Start Package clean up
    sudo apt autoremove -y >> /tmp/clean.log
    echo OS updated successfully using apt
    exit 0
fi

exit 1