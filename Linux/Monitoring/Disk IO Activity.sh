#!/bin/sh

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Check if the iostat command exists if not install it
if ! [ -x "$(command -v iostat)" ]; then
    apt-get install sysstat -y
fi

# check if the iostat command exist if not exit, if it does run the command
if [ -x "$(command -v iostat)" ]; then
    echo "Disk I/O Activity:"
    echo "------------------"
    iostat -d  1
else
    echo "iostat command not found"
    exit 1
fi

