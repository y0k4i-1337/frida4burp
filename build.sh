#!/usr/bin/env bash

mkdir -p ./build
paste -sd'\n' ./config.js \
            ./native-connect-hook.js \
            ./android/fridantiroot.js \
            ./android/android-proxy-override.js \
            ./android/android-system-certificate-injection.js \
            ./android/android-certificate-unpinning.js \
            ./android/android-certificate-unpinning-fallback.js \
            > ./build/android-frida-single-script.js
echo "Build complete: ./build/android-frida-single-script.js"
