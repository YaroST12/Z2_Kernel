#!/bin/bash
kernel_dir=$PWD
rm -rf modules
export CONFIG_FILE="n7x-caf_z2_plus_defconfig"
export ARCH="arm64"
export CROSS_COMPILE="aarch64-Mi5-linux-gnu-"
export TOOL_CHAIN_PATH="${HOME}/build/z2/Custom_Toolchains/bin"
export LD_LIBRARY_PATH="${TOOL_CHAIN_PATH}/../lib"
export PATH=$PATH:${TOOL_CHAIN_PATH}
export objdir="${kernel_dir}/../out"
cd $kernel_dir
compile() {
  make O=$objdir ARCH=arm64 CROSS_COMPILE=${TOOL_CHAIN_PATH}/${CROSS_COMPILE}  $CONFIG_FILE -j8
  make O=$objdir -j8
}
module(){
  mkdir modules
  find . -name '*.ko' -exec cp -av {} modules/ \;
  ${TOOL_CHAIN_PATH}/${CROSS_COMPILE}strip --strip-unneeded modules/*
  cp modules/wlan.ko ../../../out/target/product/z2_plus/system/lib/modules/wlan.ko
  
}
dtbuild(){
  cd $kernel_dir
  ./tools/dtbToolCM -2 -o $objdir/arch/arm64/boot/dt.img -s 4096 -p $objdir/scripts/dtc/ $objdir/arch/arm64/boot/dts/
}
compile 
cd ${objdir}
module
cd ${kernel_dir}
