#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd openh264

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    ARCH=arm
  ;;
  x86)
    ARCH=x86
  ;;
esac

echo $CFLAGS

make \
  OS=android \
  NDKROOT=$HOME/Library/Android/sdk/ndk-bundle \
  TARGET=android-21 \
  ARCH="$ARCH" \
  PREFIX="${TOOLCHAIN_PREFIX}" \
  NDKLEVEL=21 \
  clean

make \
  OS=android \
  NDKROOT=$HOME/Library/Android/sdk/ndk-bundle \
  TARGET=android-21 \
  ARCH="$ARCH" \
  PREFIX="${TOOLCHAIN_PREFIX}" \
  NDKLEVEL=21 \
  -j${NUMBER_OF_CORES} install || exit 1

popd
