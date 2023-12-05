#!/usr/bin/env sh
# https://securitychops.com/2019/08/31/dev/random/one-liner-to-install-burp-cacert-into-android.html
#
BURP_PROXY="$1"
if [ -z "$BURP_PROXY" ]; then
    BURP_PROXY="http://127.0.0.1:8080"
fi
echo "Using Burp proxy: $BURP_PROXY"

DST_DIR="./certs"
mkdir -p "$DST_DIR"

echo "Downloading certificate from Burp proxy"
curl -s --proxy "$BURP_PROXY" -o "$DST_DIR/cacert.der" http://burp/cert &&
    echo "Certificate downloaded to $DST_DIR/cacert.der"

echo "Converting certificate to PEM format"
openssl x509 -inform DER -in "$DST_DIR/cacert.der" -out "$DST_DIR/cacert.pem" &&
    echo "Certificate converted to $DST_DIR/cacert.pem"
