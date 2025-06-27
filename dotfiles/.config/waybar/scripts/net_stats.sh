#!/usr/bin/env bash
# Network speed with packet loss
set -euo pipefail

iface=$(ip route get 1 | awk '{print $5; exit}')
rx_prev=$(cat /sys/class/net/$iface/statistics/rx_bytes)
tx_prev=$(cat /sys/class/net/$iface/statistics/tx_bytes)
sleep 1
rx_now=$(cat /sys/class/net/$iface/statistics/rx_bytes)
tx_now=$(cat /sys/class/net/$iface/statistics/tx_bytes)
rx_rate=$(( (rx_now-rx_prev)/1024 ))
tx_rate=$(( (tx_now-tx_prev)/1024 ))

loss=""
if command -v ping >/dev/null; then
  loss=$(ping -c 4 -q 8.8.8.8 2>/dev/null | awk -F',' '/packet loss/{print $3}' | tr -d ' ')
fi

echo "net ${rx_rate}K/${tx_rate}K ${loss}"
