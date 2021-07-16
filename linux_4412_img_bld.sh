#!/bin/bash

#extract the linux kernel 4.4.12
tar -xvf linux-4.4.12.tar.xz 
#change directory for patch
cd linux-4.4.12/
#extract the real time patch
xzcat ../patch-4.4.12-rt19.patch.xz | patch -p1
#apply patch for status led pin change and fix kernel location in boot
patch -p1 < ./../boot_status_led.patch 
#return to the root directory of the repo
cd ..
