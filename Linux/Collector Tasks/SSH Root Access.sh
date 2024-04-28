#!/bin/bash

EXIT_CODE=1  # Default exit code set to 1

if grep -q -i "PermitRootLogin yes" /etc/ssh/sshd_config; then
    echo "Warning: Root login via SSH is enabled"
    # Add your alerting mechanism here (e.g., email, syslog, etc.)
else
    echo "Root login via SSH is not enabled"
    EXIT_CODE=0  # Set exit code to 0 if root login via SSH is not enabled
fi

exit $EXIT_CODE