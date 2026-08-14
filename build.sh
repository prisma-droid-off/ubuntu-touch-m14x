#!/bin/bash
set -xe

export DEVICE="m14x"
export ARCH=arm64
export SUBARCH=arm64
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TARGET_SOC=s5e8535
export SOC_NAME=s5e8535
export DTC_FLAGS="-@"
export PLATFORM_VERSION=13
export ANDROID_MAJOR_VERSION=t
export DEPMOD=depmod

[ -d build ] || git clone https://gitlab.com/ubports/community-ports/halium-generic-adaptation-build-tools build
./build/build.sh "$@"
