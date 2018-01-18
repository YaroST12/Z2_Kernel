#!/bin/bash
kernel_dir=$PWD
export CONFIG_FILE="z2_plus_defconfig"
export ARCH="arm64"
export KBUILD_BUILD_HOST="CryptoCountry"
export KBUILD_BUILD_USER="Yaro330"
export LOCALVERSION="-FokkenLazerSight"
export CROSS_COMPILE="aarch64-linaro-linux-android-"
export TOOL_CHAIN_PATH="${HOME}/build/z2/aarch64-linaro-7.x/bin"
export LD_LIBRARY_PATH="${TOOL_CHAIN_PATH}/../lib"
export PATH=$PATH:${TOOL_CHAIN_PATH}
export objdir="${kernel_dir}/../out"
export builddir="${kernel_dir}/build"
cd $kernel_dir
compile() {
	make O=$objdir ARCH=arm64 CROSS_COMPILE=${TOOL_CHAIN_PATH}/${CROSS_COMPILE} $CONFIG_FILE -j8
	make O=$objdir -j8
}
ramdisk() {
	cd ${objdir}
	cp arch/arm64/boot/Image.gz-dtb $builddir/Image.gz-dtb
}
dtbuild(){
	cd $kernel_dir
	./tools/dtbToolCM -2 -o $objdir/arch/arm64/boot/dt.img -s 4096 -p $objdir/scripts/dtc/ $objdir/arch/arm64/boot/dts/
}
compile 
ramdisk
cd ${kernel_dir}