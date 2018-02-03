#!/bin/bash
kernel_dir=$PWD
export CONFIG_FILE="z2_plus_defconfig"
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_HOST="CryptoCountry"
export KBUILD_BUILD_USER="Yaro330"
export LOCALVERSION="-FokkenLazerSight"
export CLANG_TRIPLE="aarch64-linux-gnu-"
export CROSS_COMPILE="${HOME}/build/z2/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-"
export CLANG_TCHAIN="${HOME}/build/z2/linux-x86/clang-4536805/bin/clang"
export LD_LIBRARY_PATH="${TOOL_CHAIN_PATH}/../lib"
export PATH=$PATH:${TOOL_CHAIN_PATH}
export objdir="${kernel_dir}/out"
export builddir="${kernel_dir}/build"
cd $kernel_dir
make_a_fucking_defconfig() 
{
	make ARCH="arm64" O=$objdir $CONFIG_FILE -j8
}
compile() 
{
	make CC="${CLANG_TCHAIN}" O=$objdir -j8 Image.gz-dtb
}
ramdisk() 
{
	cd ${objdir}
	cp arch/arm64/boot/Image.gz-dtb $builddir/Image.gz-dtb
}
make_a_fucking_defconfig
compile 
ramdisk
cd ${kernel_dir}