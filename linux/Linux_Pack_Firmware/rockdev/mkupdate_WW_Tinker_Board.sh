#!/bin/bash
pause()
{
echo "Press any key to quit:"
read -n1 -s key
exit 1
}
echo "start to make update.img..."
if [ ! -f "Image/parameter.txt" ]; then
	echo "Error:No found parameter!"
#	pause
fi
if [ ! -f "package-file-Tinker_Board_2" ]; then
	echo "Error:No found package-file!"
#	pause
fi

mv package-file package-file.bak
cp package-file-Tinker_Board_2 package-file

./afptool -pack ./ Image/update.img || pause
./rkImageMaker -RK32 Image/MiniLoaderAll.bin Image/update.img update.img -os_type:androidos || pause

rm package-file
mv package-file.bak package-file

echo "Making update.img OK."
#echo "Press any key to quit:"
#read -n1 -s key
exit 0
