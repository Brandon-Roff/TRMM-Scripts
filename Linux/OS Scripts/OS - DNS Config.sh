#!/usr/bin/env bash
# OS - DNS Config (from DNS Config.sh)
NAMESERVERS=${NAMESERVERS:-"1.1.1.1 8.8.8.8"}
cp /etc/resolv.conf /etc/resolv.conf.bak 2>/dev/null || true
grep -v '^nameserver' /etc/resolv.conf > /tmp/resolv.tmp
for ns in $NAMESERVERS; do echo "nameserver $ns" >> /tmp/resolv.tmp; done
cat /tmp/resolv.tmp > /etc/resolv.conf
echo "Applied DNS: $NAMESERVERS"; exit 0