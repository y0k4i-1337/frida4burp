#!/usr/bin/env bash

mkdir -p ./build
paste -sd'\n' ./config.js \
    ./android/android-antiroot.js \
    ./android/fridantiroot.js \
    ./native-connect-hook.js \
    ./native-tls-hook.js \
    ./android/android-proxy-override.js \
    ./android/android-system-certificate-injection.js \
    ./android/frida-multiple-unpinning.js \
    ./android/android-certificate-unpinning.js \
    ./android/android-certificate-unpinning-fallback.js \
    >./build/android-frida-single-script.js
echo "Build complete: ./build/android-frida-single-script.js"
