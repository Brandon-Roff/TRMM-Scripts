#!/bin/bash
# Simple internet speed test using speedtest-cli

if ! command -v speedtest-cli &> /dev/null; then
    echo "speedtest-cli is not installed. Install with: sudo apt install speedtest-cli"
    exit 1
fi

speedtest-cli
