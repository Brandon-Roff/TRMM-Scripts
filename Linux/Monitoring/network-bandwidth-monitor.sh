#!/bin/bash
if ! command -v ifstat &> /dev/null; then
  echo "ifstat not installed. Install with: sudo apt install ifstat"
  exit 1
fi
ifstat 1 10
