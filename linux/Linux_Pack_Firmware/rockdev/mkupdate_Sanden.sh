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


echo "Sanden start to make update.img..."

if [ ! -f "Image/parameter.txt" ]; then
        echo "Error:No found parameter!"
#       pause
fi
if [ ! -f "package-file-Sanden" ]; then
        echo "Error:No found package-file-Sanden!"
#       pause
fi

./afptool -pack ./ Image/update.img ./package-file-Sanden || pause
./rkImageMaker -RK3568 Image/MiniLoaderAll.bin Image/update.img update.img -os_type:androidos || pause
echo "Making Sanden update.img OK."
exit 0
