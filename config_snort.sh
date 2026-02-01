#!/bin/bash

SNORT_CONF="/usr/local/etc/snort/snort.lua"
RULE_DIR="/usr/local/etc/snort/rules"
RULE_FILE="$RULE_DIR/local.rules"

echo "[*] Creating rule directory..."
sudo mkdir -p "$RULE_DIR"

echo "[*] Creating ICMP detection rule..."
sudo tee "$RULE_FILE" > /dev/null <<EOF
alert icmp any any -> any any (msg:"ICMP Ping Detected"; sid:1000001;)
EOF

echo "[*] Writing snort.lua configuration..."
sudo tee "$SNORT_CONF" > /dev/null <<EOF
RULE_PATH = "$RULE_DIR"

ips =
{
    enable_builtin_rules = true,

    rules = [[
        include ]] .. RULE_PATH .. [[/local.rules
    ]]
}
EOF

echo "[*] Testing Snort configuration..."
sudo snort -T -c "$SNORT_CONF"
