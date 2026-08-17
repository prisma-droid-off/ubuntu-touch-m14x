#!/bin/bash

DEVICE=$(getprop ro.product.vendor.device)

if [[ "$DEVICE" == "m14x" || "$DEVICE" == "M14X" ]]; then
    sleep 0.5
    if [ -e /sys/devices/virtual/camera/flash/rear_flash ]; then
        sudo chown phablet /sys/devices/virtual/camera/flash/rear_flash
    fi
fi
