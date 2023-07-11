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


echo "Sanden_VM start to make update.img..."

if [ ! -f "Image/parameter.txt" ]; then
        echo "Error:No found parameter!"
#       pause
fi
if [ ! -f "package-file-Sanden_VM" ]; then
        echo "Error:No found package-file-Sanden_VM!"
#       pause
fi

./afptool -pack ./ Image/update.img ./package-file-Sanden_VM || pause
./rkImageMaker -RK3568 Image/MiniLoaderAll.bin Image/update.img update.img -os_type:androidos || pause
echo "Making Sanden_VM update.img OK."
exit 0
