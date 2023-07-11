#!/bin/bash
pause() {
  echo "Press any key to quit:"
  read -n1 -s key
  exit 1
}


if [ ! -f "$IMAGE_PATH/parameter.txt" ]; then
	echo "Error:No found parameter!"
#	pause
fi


echo "Sanden_CM start to make update.img..."

if [ ! -f "Image/parameter.txt" ]; then
        echo "Error:No found parameter!"
#       pause
fi
if [ ! -f "package-file-Sanden_CM" ]; then
        echo "Error:No found package-file-Sanden_CM!"
#       pause
fi

./afptool -pack ./ Image/update.img ./package-file-Sanden_CM || pause
./rkImageMaker -RK3568 Image/MiniLoaderAll.bin Image/update.img update.img -os_type:androidos || pause
echo "Making Sanden_CM update.img OK."
exit 0
