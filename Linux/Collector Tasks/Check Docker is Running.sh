#!/bin/bash
if ! command -v docker &> /dev/null; then
    echo "Warning: Docker is not installed."
    exit 1
fi