#!/usr/bin/env bash
# Check - Internet Connectivity (from test-internet.sh)
HOSTS=(8.8.8.8 1.1.1.1 google.com)
for h in "${HOSTS[@]}"; do if ping -c 2 -W 2 "$h" >/dev/null 2>&1; then echo "$h reachable"; else echo "$h NOT reachable"; fi; done
exit 0