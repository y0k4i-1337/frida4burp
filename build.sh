#!/usr/bin/env bash

mkdir -p ./build
paste -sd'\n' ./config.js \
    ./android/android-disable-root-detection.js \
    ./android/android-proxy-override.js \
    ./android/android-system-certificate-injection.js \
    ./android/android-certificate-unpinning.js \
    ./android/android-certificate-unpinning-fallback.js \
    >./build/android-frida-single-script.js
echo "Build complete: ./build/android-frida-single-script.js"
paste -sd'\n' ./config.js \
    ./ios/ios-connect-hook.js \
    ./ios/ios-disable-detection.js \
    ./native-tls-hook.js \
    ./native-connect-hook.js \
    >./build/ios-frida-single-script.js
echo "Build complete: ./build/ios-frida-single-script.js"
# build for flutter
paste -sd'\n' ./config.js \
    ./android/android-disable-flutter-certificate-pinning.js \
    ./android/android-disable-root-detection.js \
    ./android/android-proxy-override.js \
    ./android/android-system-certificate-injection.js \
    >./build/android-frida-flutter-single-script.js
echo "Build complete: ./build/android-frida-flutter-single-script.js"
