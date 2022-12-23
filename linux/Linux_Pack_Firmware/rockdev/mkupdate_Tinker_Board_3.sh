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


echo "Tinker Board 3 start to make update.img..."

if [ ! -f "Image/parameter.txt" ]; then
        echo "Error:No found parameter!"
#       pause
fi
if [ ! -f "package-file-Tinker_Board_3" ]; then
        echo "Error:No found package-file-Tinker_Board_3!"
#       pause
fi

./afptool -pack ./ Image/update.img ./package-file-Tinker_Board_3 || pause
./rkImageMaker -RK3568 Image/MiniLoaderAll.bin Image/update.img update.img -os_type:androidos || pause
echo "Making Tinker Board 3 update.img OK."
exit 0
