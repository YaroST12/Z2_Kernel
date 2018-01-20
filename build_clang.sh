#!/bin/bash
kernel_dir=$PWD
export CONFIG_FILE="z2_plus_defconfig"
export ARCH="arm64"
export KBUILD_BUILD_HOST="CryptoCountry"
export KBUILD_BUILD_USER="Yaro330"
export LOCALVERSION="-FokkenLazerSight"
export CROSS_COMPILE="aarch64-linaro-linux-android-"
export TOOL_CHAIN_PATH="${HOME}/build/z2/aarch64-linaro-7.x/bin"
export CLANG_TCHAIN="${HOME}/build/z2/linux-x86/clang-4536805/bin/clang"
export LD_LIBRARY_PATH="${TOOL_CHAIN_PATH}/../lib"
export PATH=$PATH:${TOOL_CHAIN_PATH}
export objdir="${kernel_dir}/out"
export builddir="${kernel_dir}/build"
cd $kernel_dir
make_a_fucking_defconfig() {
	make ARCH="arm64" O=$objdir $CONFIG_FILE
	}
compile() {
		PATH=${BIN_FOLDER}:${PATH} make O=$objdir \
		CC="${CLANG_TCHAIN}" \
		CLANG_TRIPLE=aarch64-linux-android- \
		CROSS_COMPILE=${TOOL_CHAIN_PATH} \
		HOSTCC="${CLANG_TCHAIN}"
		$CONFIG_FILE -j8
	}
ramdisk() {
	cd ${objdir}
	cp arch/arm64/boot/Image.gz-dtb $builddir/Image.gz-dtb
	}
make_a_fucking_defconfig
compile 
ramdisk
cd ${kernel_dir}