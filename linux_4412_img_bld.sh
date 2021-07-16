#!/bin/bash

#extract the linux kernel 4.4.12
tar -xvf linux-4.4.12.tar.xz 
#change directory for patch
cd linux-4.4.12/
#extract the real time patch
xzcat ../patch-4.4.12-rt19.patch.xz | patch -p1
#apply patch for status led pin change and fix kernel location in boot
patch -p1 < ./../boot_status_led.patch 
#auto detection of amount of threads to use
JOBS="-j$(($(nproc --all) + 1))"
#make config file for needed target
make ARCH=arm CROSS_COMPILE=/opt/build-tools-gcc/arm-linux-gnueabi/bin/arm-linux-gnueabi- at91_dt_defconfig
#make dtb file
make ARCH=arm CROSS_COMPILE=/opt/build-tools-gcc/arm-linux-gnueabi/bin/arm-linux-gnueabi- at91sam9g25ek.dtb
#build the kernel image
make "${JOBS}" ARCH=arm CROSS_COMPILE=/opt/build-tools-gcc/arm-linux-gnueabi/bin/arm-linux-gnueabi- zImage 
#build uimage kernel file
#mkimage -A arm -O linux -T kernel -C none -a 0x20008000 -e 0x20008000 -n "Linux kernel V 4.4.12-rt19" -d arch/arm/boot/zImage uImage
#return to the root directory of the repo
cd ..
#copy the kernel image to root directory
cp linux-4.4.12/arch/arm/boot/zImage zImage
#copy the uImage kernel image to root directory
#cp linux-4.4.12/uImage uImage
#copy the kernel dtb file to root directory
cp linux-4.4.12/arch/arm/boot/dts/at91sam9g25ek.dtb at91sam9g25ek.dtb
