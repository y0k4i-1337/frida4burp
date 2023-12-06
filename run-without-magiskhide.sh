#!/usr/bin/env bash

run_proc=$(adb shell monkey -p $1 1)
get_pid=$(adb shell ps | grep -i $1 | awk '{printf $2}')

# Shift to the next argument
shift

if [[ -z "$get_pid" ]];
then
    echo "Didn't find PID :("
else
    echo "Attaching to process.."
    # Call frida passing any remaining arguments
    frida -U  -p $get_pid $@
fi
