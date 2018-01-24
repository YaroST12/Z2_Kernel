#!/bin/bash
kernel_dir=$PWD
export CONFIG_FILE="z2_plus_defconfig"
export ARCH="arm64"
export KBUILD_BUILD_HOST="CryptoCountry"
export KBUILD_BUILD_USER="Yaro330"
export LOCALVERSION="-FokkenLazerSight"
export CROSS_COMPILE="aarch64-linux-gnu-"
export TOOL_CHAIN_PATH="${HOME}/build/z2/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin"
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
	PATH=${BIN_FOLDER}:${PATH} make O=$objdir -j8 \
	CC="${CLANG_TCHAIN}" \
	CLANG_TRIPLE=aarch64-linux-gnu- \
	CROSS_COMPILE=${TOOL_CHAIN_PATH}/${CROSS_COMPILE} \
	HOSTCC="${CLANG_TCHAIN}"
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