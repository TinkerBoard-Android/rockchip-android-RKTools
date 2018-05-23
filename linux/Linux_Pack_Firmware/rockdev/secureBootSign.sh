#!/bin/bash
Debug=1

Tools="."
Img="."
Output="./signed"
Key="./keys"
Log="./log"

dbg_print()
{
	if [ $Debug ]; then 
		echo "[SecureBootSign] $1 : $2" | tee -a $Log
	fi
}

prepare()
{
	if [ -e $Log ]; then
		rm $Log
	fi

	if [ ! -f $Img/update.img ]; then
		dbg_print Error "Can't find update.img !!! Error !!!"
		exit 1
	fi

	if [ -d $Output ]; then
		dbg_print Info "Clean old data ..."
		rm -rf $Output 
	fi
	mkdir -p $Output

	if [ ! -e $Output ]; then
		dbg_print Error "Create output directory fail !!!"
		exit 1
	fi

	if [ ! -d $Key -a -e $Key/private. ]; then
		dbg_print Error "Can't find key folder !!!"
		exit 1
	elif [ ! -e $Key/privateKey.bin -o ! -e $Key/publicKey.bin ]; then 
		dbg_print Error "Can't find sign key !!!"
		exit 1
	fi
}

unpack()
{
	dbg_print Info "Start to unpack union firmware"
	$Tools/rkImageMaker -unpack $Img/update.img $Output >> $Log

	dbg_print Info "Start to unpack andorid firmwar"
	$Tools/afptool -unpack $Output/firmware.img $Output/Android >> $Log
}

sign()
{
	dbg_print Info "Start to signEx Loader (boot.bin)."
	$Tools/secureBootConsole -slx $Key/privateKey.bin $Key/publicKey.bin $Output/boot.bin >> $Log
	
	dbg_print Info "Start to sign file (trust.img)."
	$Tools/secureBootConsole -si $Key/privateKey.bin $Output/Android/Image/trust.img >> $Log

	dbg_print Info "Start to sign file (uboot.img)."
	$Tools/secureBootConsole -si $Key/privateKey.bin $Output/Android/Image/uboot.img >> $Log

	dbg_print Info "Start to sign file (boot.img)."
	$Tools/secureBootConsole -si $Key/privateKey.bin $Output/Android/Image/boot.img >> $Log

	dbg_print Info "Start to sign file (recovery.img)."
	$Tools/secureBootConsole -si $Key/privateKey.bin $Output/Android/Image/recovery.img >> $Log
}

pack()
{
        # The tool mv some files to different path when unpacking...
        # Put them back to correct path.
        dbg_print Debug "Move files to correct location."
        mv $Output/Android/parameter.txt $Output/Android/MiniLoaderAll.bin $Output/Android/Image

	dbg_print Info "Start to pack android firmware."
	$Tools/afptool -pack $Output/Android/ $Output/firmware.img >> $Log

	dbg_print Info "Start to pack union firmware."
	$Tools/rkImageMaker -RK32 $Output/boot.bin $Output/firmware.img $Output/output.img -os_type:ANDROIDOS >> $Log	

	dbg_print Info "Update signed image."
	mv $Output/output.img $Img/update.img
}

prepare
unpack
sign
pack

dbg_print Info "Done."

