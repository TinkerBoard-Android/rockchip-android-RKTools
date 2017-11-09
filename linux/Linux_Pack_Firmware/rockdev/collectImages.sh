#!/bin/bash -e

TARGET_COLLECT_DIR="Image"

function END()
{
    exit $ERROR
}

if [ -e $TARGET_COLLECT_DIR ]; then
    echo "Found the directory $TARGET_COLLECT_DIR. Removing it now."
    rm -rf $TARGET_COLLECT_DIR
fi

mkdir Image

cp ../../../../u-boot/rk3288_loader_v1.05.233.bin ./Image/MiniLoaderAll.bin

cp ../../../../u-boot/trust.img ./Image/trust.img

cp ../../../../u-boot/uboot.img ./Image/uboot.img

cp ../../../../kernel/kernel.img  ./Image/

cp ../../../../kernel/resource.img  ./Image/

cp ../../../../rockdev/Image-rk3288/boot.img  ./Image/

cp ../../../../rockdev/Image-rk3288/misc.img  ./Image/

cp ../../../../rockdev/Image-rk3288/recovery.img  ./Image/

cp ../../../../rockdev/Image-rk3288/system.img  ./Image/

cp ../../../../rockdev/Image-rk3288/parameter.txt ./Image/

cp ../../../../rockdev/Image-rk3288/vendor0.img ./Image/

cp ../../../../rockdev/Image-rk3288/vendor1.img ./Image/
echo "Done"
