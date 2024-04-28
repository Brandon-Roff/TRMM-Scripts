#!/bin/bash 
if systemctl is-active --quiet ssh; then
    echo "SSH service is running."
    exit 0
else
    echo "SSH service is not running."
    exit 1
fi