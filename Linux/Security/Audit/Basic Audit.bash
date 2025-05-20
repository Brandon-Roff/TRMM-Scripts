#!/bin/bash

score=0
total=10

echo "=== Linux Server Security Audit ==="

# 1. Check for root login via SSH
echo -n "[1] Root login via SSH disabled: "
if grep -q "^PermitRootLogin no" /etc/ssh/sshd_config; then
    echo "✅"
    ((score++))
else
    echo "❌"
fi

# 2. SSH Password Authentication disabled
echo -n "[2] SSH password authentication disabled: "
if grep -q "^PasswordAuthentication no" /etc/ssh/sshd_config; then
    echo "✅"
    ((score++))
else
    echo "❌"
fi

# 3. Firewall active
echo -n "[3] Firewall (UFW/iptables/firewalld) active: "
if command -v ufw &>/dev/null && ufw status | grep -q "Status: active"; then
    echo "✅ (UFW)"
    ((score++))
elif command -v firewall-cmd &>/dev/null && firewall-cmd --state &>/dev/null; then
    echo "✅ (firewalld)"
    ((score++))
elif iptables -L | grep -q "ACCEPT"; then
    echo "✅ (iptables)"
    ((score++))
else
    echo "❌"
fi

# 4. Automatic security updates enabled
echo -n "[4] Unattended upgrades enabled: "
if [ -f /etc/apt/apt.conf.d/20auto-upgrades ]; then
    echo "✅"
    ((score++))
else
    echo "❌"
fi

# 5. Fail2Ban installed
echo -n "[5] Fail2Ban installed: "
if systemctl is-active --quiet fail2ban; then
    echo "✅"
    ((score++))
else
    echo "❌"
fi

# 6. SELinux or AppArmor enabled
echo -n "[6] SELinux/AppArmor enabled: "
if command -v getenforce &>/dev/null && [ "$(getenforce)" != "Disabled" ]; then
    echo "✅ (SELinux)"
    ((score++))
elif aa-status 2>/dev/null | grep -q "profiles are in enforce mode"; then
    echo "✅ (AppArmor)"
    ((score++))
else
    echo "❌"
fi

# 7. World-writable files check
echo -n "[7] No world-writable files in /: "
if find / -xdev -type f -perm -0002 ! -path "/proc/*" 2>/dev/null | grep -q .; then
    echo "❌"
else
    echo "✅"
    ((score++))
fi

# 8. /tmp mounted with noexec
echo -n "[8] /tmp mounted with noexec: "
if mount | grep -E "\s/tmp\s" | grep -q "noexec"; then
    echo "✅"
    ((score++))
else
    echo "❌"
fi

# 9. Password policy in place
echo -n "[9] Password policy (minlen >= 8): "
if grep -q "minlen\s*[>=]\s*8" /etc/security/pwquality.conf 2>/dev/null || grep -q "minlen\s*=\s*8" /etc/pam.d/common-password 2>/dev/null; then
    echo "✅"
    ((score++))
else
    echo "❌"
fi

# 10. Suspicious users check
echo -n "[10] No suspicious users (UID 0 except root): "
if awk -F: '($3 == 0 && $1 != "root") { print $1 }' /etc/passwd | grep -q .; then
    echo "❌"
else
    echo "✅"
    ((score++))
fi

echo
echo "Final Security Score: $score / $total"

if [ "$score" -eq 10 ]; then
    echo "✅ Excellent security!"
elif [ "$score" -ge 7 ]; then
    echo "🟡 Good, but could improve."
elif [ "$score" -ge 4 ]; then
    echo "🔴 Poor, action recommended."
else
    echo "🚨 Critical: High risk environment!"
fi
