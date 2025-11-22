#!/usr/bin/env bash
# Check - Speed Test (from speed-test.sh)
command -v speedtest-cli >/dev/null 2>&1 || { echo "Install speedtest-cli"; exit 1; }
speedtest-cli; exit 0