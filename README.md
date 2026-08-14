# Ubuntu Touch port for m14x

This repository contains the build and installation steps for an Ubuntu Touch port for the m14x device.

## Prerequisites

Install required packages on Ubuntu 24.04 (one-liner):

```bash
sudo apt update && sudo apt install -y git gnupg flex bison gperf build-essential zip curl libc6-dev libx11-dev libreadline-dev libgl-dev g++-multilib mingw-w64-i686-dev python3-markdown libxml2-dev
```

(If the one-liner above is missing packages, install the dependencies listed in the repository build scripts or your distribution's documentation.)

## Build

1. Start a build (example using `workdir` as build directory):

```bash
./build.sh -b workdir
```

2. Prepare a fake OTA archive:

```bash
./build/prepare-fake-ota.sh out/device_**_usrmerge.tar.xz ota
```

3. Produce system images from the OTA:

```bash
./build/system-image-from-ota.sh ota/ubuntu_command images
```

One-liner combining the steps:

```bash
./build.sh -b workdir && \
./build/prepare-fake-ota.sh out/device_**_usrmerge.tar.xz ota && \
./build/system-image-from-ota.sh ota/ubuntu_command images
```

## Output

The build produces an `./images` folder containing (typically) the following files:

- boot.img
- dtbo.img
- system.img
- init_boot.img
- rootfs.img

You can delete `system.img` and `dtbo.img` if not needed, and rename `rootfs.img` to `ubuntu.img` for installation.

## Installation

Follow these steps to install the built image onto the device:

1. Flash a custom vendor image with encryption disabled and vbmeta disabled.
2. Boot to recovery. (I built ofox for this device and recommend using it.)
3. Flash `boot.img`:

```bash
fastboot flash boot boot.img
```

4. Flash `init_boot.img`:

```bash
fastboot flash init_boot init_boot.img
```

5. From the custom recovery, wipe the following partitions:

- /dalvik
- /data
- /cache
- /internal_storage
- /metadata

6. Change `/data` filesystem to ext4.

Important notes:
- DO NOT WIPE /SDCARD.
- It is recommended to use an external SD card to create a backup of `/data`. If you do not have a backup option, do not proceed with flashing.
- Copy `ubuntu.img` to `/data` for installation:

```bash
adb push ubuntu.img /data/
```

Alternatively, `system.img` and `rootfs.img` are interchangeable; you can flash `ubuntu.img` into `/system` via fastboot, but this is not recommended.

## Warnings and recommendations

- Ensure you have a complete backup of user data before proceeding.
- Make sure the vendor image has encryption disabled and vbmeta verification disabled; otherwise the device may not boot the custom images.
- If you are unfamiliar with custom recoveries, partitions, or flashing, proceed with caution or seek assistance.

## Support

If you encounter build or installation issues, open an issue in this repository with:
- A clear description of the problem
- Relevant logs or terminal output
- Steps you followed prior to the failure
