#!/usr/bin/env sh
# https://securitychops.com/2019/08/31/dev/random/one-liner-to-install-burp-cacert-into-android.html
#
BURP_PROXY="$1"
if [ -z "$BURP_PROXY" ]; then
    BURP_PROXY="http://127.0.0.1:8080"
fi
echo "Using Burp proxy: $BURP_PROXY"

DST_DIR="./certs"

# Verify if directory exists, if not create it
if [ ! -d "$DST_DIR" ]; then
    echo "Creating directory $DST_DIR for storing certificates"
    mkdir -p "$DST_DIR"
else
    echo "Directory $DST_DIR already exists. Cleaning up existing certificates"
    rm -f "$DST_DIR"/*
fi

echo "Downloading certificate from Burp proxy"
curl -s --proxy "$BURP_PROXY" -o "$DST_DIR/cacert.der" http://burp/cert &&
    echo "Certificate downloaded to $DST_DIR/cacert.der"

echo "Converting certificate to PEM format"
openssl x509 -inform DER -in "$DST_DIR/cacert.der" -out "$DST_DIR/cacert.pem" &&
    echo "Certificate converted to $DST_DIR/cacert.pem"

echo "Calculating hash from PEM certificate"
HASH=$(openssl x509 -inform PEM -subject_hash_old -in "$DST_DIR/cacert.pem" | head -1) &&
    echo "Certificate hash: $HASH"

echo "Copying PEM certificate to $DST_DIR/$HASH.0"
cp "$DST_DIR/cacert.pem" "$DST_DIR/$HASH.0" &&
    echo "Certificate copied to $DST_DIR/$HASH.0"
