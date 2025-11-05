#!/usr/bin/env sh
# This script sets up Corellium device for use with Burp Suite
# The script expects VPN connection to be active and
# device IP to be passed as the first argument.
# The certificate should already be downloaded using getburpcert.sh
# Optional second argument is the Burp proxy (e.g., 10.11.3.2:8080)

# Usage: ./corellium-setup.sh <device_ip> [burp_proxy]
DEVICE_IP="$1"
if [ -z "$DEVICE_IP" ]; then
    echo "Usage: $0 <device_ip> [burp_proxy]"
    exit 1
fi

# Run script to get Burp certificate
./getburpcert.sh

CERTS_DIR="./certs"
if [ ! -d "$CERTS_DIR" ]; then
    echo "[!] Certificates directory $CERTS_DIR does not exist. Please run getburpcert.sh first."
    exit 1
fi

CERT_PATH="$CERTS_DIR/$(ls $CERTS_DIR | grep '\.0$' | head -1)"
if [ ! -f "$CERT_PATH" ]; then
    echo "[!] Certificate file not found in $CERTS_DIR. Please ensure getburpcert.sh has been run successfully."
    exit 1
fi

echo "[*] Setting up Corellium device at $DEVICE_IP for Burp Suite"

# Connect to the device and install the certificate
adb connect "$DEVICE_IP:5001"
adb root
adb push "$CERT_PATH" /system/etc/security/cacerts/

# Verify installation
echo "[*] Verifying certificate installation on device"
# Get certificate name
filename=$(basename "$CERT_PATH")
echo "[*] Expected certificate filename on device: $filename"
adb shell "ls /system/etc/security/cacerts/$filename"

# Setup proxy settings if $2 is provided
BURP_PROXY="$2"
if [ -z "$BURP_PROXY" ]; then
    echo "[-] No Burp proxy provided, skipping proxy setup."
    exit 0
fi

echo "[*] Setting up proxy settings on device"
adb shell settings put global http_proxy $BURP_PROXY

echo "[*] Verifying proxy settings on device"
adb shell settings get global http_proxy

echo "[*] Corellium device setup complete.\n"
echo "[*] To remove the proxy settings, run:"
echo "adb shell settings put global http_proxy :0"
