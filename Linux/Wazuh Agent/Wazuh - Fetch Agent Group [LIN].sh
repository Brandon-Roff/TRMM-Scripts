#!/bin/bash

# Path to the ossec.conf file
CONFIG_FILE="/var/ossec/etc/ossec.conf"

# Check if the file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "File not found: $CONFIG_FILE"
    exit 1
fi

# Extract the content between <groups> and </groups>
GROUPS_CONTENT=$(sed -n 's:.*<groups>\(.*\)</groups>.*:\1:p' "$CONFIG_FILE")

# Check if content was found
if [[ -z "$GROUPS_CONTENT" ]]; then
    echo "No groups found in the file."
else
    echo "$GROUPS_CONTENT"
fi