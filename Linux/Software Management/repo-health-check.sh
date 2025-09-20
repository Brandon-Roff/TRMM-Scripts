#!/bin/bash
# Repository Health Check: Test all configured repositories for connectivity and errors
if ! command -v apt &> /dev/null; then
  echo "This script requires apt."
  exit 1
fi
sudo apt update -o Debug::Acquire::http=true 2>&1 | grep -E 'Err:|Hit:|Ign:'
