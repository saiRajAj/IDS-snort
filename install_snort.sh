#!/bin/bash

echo "[*] Updating system..."
sudo apt update -y

echo "[*] Installing Snort..."
sudo apt install snort -y

echo "[*] Verifying Snort installation..."
snort -V
