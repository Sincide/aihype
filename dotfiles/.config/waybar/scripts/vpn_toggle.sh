#!/usr/bin/env bash
# Toggle VPN connection and report latency
set -euo pipefail

VPN_IF="wg0"

if [ "${1:-}" = "toggle" ]; then
  if ip link show "$VPN_IF" >/dev/null 2>&1; then
    sudo wg-quick down "$VPN_IF" && notify-send "VPN" "Disconnected"
  else
    sudo wg-quick up "$VPN_IF" && notify-send "VPN" "Connected"
  fi
  exit 0
fi

status="off"
if ip link show "$VPN_IF" >/dev/null 2>&1; then
  status="on"
  latency=$(ping -c1 -w1 8.8.8.8 2>/dev/null | awk -F'/' 'END{print $5 "ms"}')
  echo "vpn $status $latency"
else
  echo "vpn $status"
fi
