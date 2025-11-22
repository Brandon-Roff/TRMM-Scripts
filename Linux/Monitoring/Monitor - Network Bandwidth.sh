#!/usr/bin/env bash
# Monitor - Network Bandwidth (from network-bandwidth-monitor.sh)
IFACE=${IFACE:-$(ip route get 8.8.8.8 2>/dev/null | awk 'NR==1 {print $5}')}
[ -z "$IFACE" ] && IFACE="eth0"
RX1=$(cat /sys/class/net/$IFACE/statistics/rx_bytes); TX1=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
sleep 1
RX2=$(cat /sys/class/net/$IFACE/statistics/rx_bytes); TX2=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
echo "Interface $IFACE RX:$((RX2-RX1))B/s TX:$((TX2-TX1))B/s"
exit 0