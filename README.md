# Ubuntu Touch Port for m14x

## Prerequisites
   * one liner for ubuntu 24.04:
     sudo apt update && sudo apt install -y git gnupg flex bison gperf build-essential zip curl libc6-dev libx11-dev libreadline-dev libgl-dev g++-multilib mingw-w64-i686-dev python3-markdown libxml2-utils xsltproc zlib1g-dev schedtool liblz4-tool bc lzop imagemagick libncurses-dev rsync ca-certificates cpio kmod libssl-dev libffi-dev libsqlite3-dev libbz2-dev libelf-dev unzip wget xz-utils android-sdk-libsparse-utils jq && wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz && tar -xf Python-2.7.18.tar.xz && cd Python-2.7.18 && ./configure --enable-optimizations --prefix=/usr/local && make -j$(nproc) && sudo make altinstall && sudo ln -sf /usr/local/bin/python2.7 /usr/local/bin/python2

## build steps:
  ./build.sh -b workdir
  ./build/prepare-fake-ota.sh out/device_**_usrmerge.tar.xz ota
  ./build/system-image-from-ota.sh ota/ubuntu_command images
*  *one-liner*:
   ./build.sh -b workdir && ./build/prepare-fake-ota.sh out/device_**_usrmerge.tar.xz ota && ./build/system-image-from-ota.sh ota/ubuntu_command images

* this will generate a ./images folder, there will be 5 files:
  boot.img dtbo.img system.img init_boot.img rootfs.img

* from here you can delete system.img dtbo.img and rename rootfs.img to ubuntu.img

## Instalation: 
  * flash a custom vendor with disabled encription and disabled vbmeta
  * boot to recovery, i built ofox for this device so i recommend that.
  * flash boot.img
  * flash init_boot.img
  * from custom recovery wipe /dalvik /data /cache /internal_storage /metadata
  * then change /data fs to ext4
  ### **DONT WIPE /SDCARD**
  *  im using an external sd to create a backup for /data 
  *  if you don't have one i don't recommend flashing this!
  ### **COPY UBUNTU.IMG TO /DATA**
  *   now for install you can copy ubuntu.img to /data and enjoy ubuntu touch
  *   system.img and rootfs.img are interchangable 
  so you can also flash ubuntu.img into /system via fastboot
  but i don't recommend.
