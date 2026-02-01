#!/bin/bash

SNORT_CONF="/usr/local/etc/snort/snort.lua"

echo "[*] Detecting network interface..."
IFACE=$(ip route | awk '/default/ {print $5; exit}')
echo "[*] Using interface: $IFACE"

echo "[*] Starting Snort IDS (Press CTRL+C to stop)..."
sudo snort -A alert_fast -c "$SNORT_CONF" -i "$IFACE"
