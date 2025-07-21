#!/bin/bash

echo "=== 👥 Linux User Account Audit ==="
echo

# 1. Users with sudo/root access
echo "🔐 Users with sudo/root access:"
getent group sudo | awk -F: '{print $4}' | tr ',' '\n' | sort | uniq
echo

# 2. Users with UID 0 (should only be root)
echo "⚠️ Users with UID 0 (excluding root):"
awk -F: '($3 == 0 && $1 != "root") { print $1 }' /etc/passwd
echo

# 3. Expired or locked accounts
echo "🔒 Expired or locked user accounts:"
while IFS=: read -r username _ uid _ _ _ _; do
    if [ "$uid" -ge 1000 ]; then
        status=$(passwd -S "$username" 2>/dev/null)
        if [[ "$status" =~ "L" ]]; then
            echo "$username (Locked)"
        elif chage -l "$username" 2>/dev/null | grep -q "Account expires.*:.*[0-9]"; then
            expires=$(chage -l "$username" | grep "Account expires" | cut -d: -f2 | xargs)
            if [[ "$expires" != "never" ]]; then
                echo "$username (Expires: $expires)"
            fi
        fi
    fi
done < /etc/passwd

echo
echo "✅ Audit complete."
