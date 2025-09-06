#!/bin/bash
# Show all active network interfaces and their IP addresses
# Usage: ./show-interfaces.sh

ip -brief addr show up
