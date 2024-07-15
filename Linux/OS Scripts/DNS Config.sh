#!/bin/bash

# Define your nameservers here
nameservers="1.1.1.1, 8.8.8.8"

# Backup existing resolv.conf
cp /etc/resolv.conf /etc/resolv.conf.bak

# Clear existing nameserver entries
sed -i '/nameserver/d' /etc/resolv.conf

# Add new nameservers
for ns in $nameservers; do
    echo "nameserver $ns" >> /etc/resolv.conf
done

echo "Nameservers preset successfully:"
cat /etc/resolv.conf