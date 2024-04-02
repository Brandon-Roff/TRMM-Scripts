#!/bin/sh
# Process Monitor
# This script lists the top CPU and memory-consuming processes, aiding in identifying resource-intensive tasks.

echo "Top CPU Consuming Processes:"
echo "----------------------------"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head

echo "Top Memory Consuming Processes:"
echo "-------------------------------"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head