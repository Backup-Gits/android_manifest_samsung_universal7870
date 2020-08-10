#!/bin/bash

# configure some default settings for the build
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/platform/13540000.dwmmc0/by-name/RECOVERY"
export FOX_REPLACE_BUSYBOX_PS="1"
export FOX_USE_BASH_SHELL="1"
export FOX_USE_LZMA_COMPRESSION="1"
export FOX_USE_NANO_EDITOR="1"
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER="1"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export LC_ALL="C"
export OF_DISABLE_MIUI_SPECIFIC_FEATURES="1"
export OF_DONT_PATCH_ENCRYPTED_DEVICE="1"
export OF_FLASHLIGHT_ENABLE="0"
export OF_MAINTAINER="Astrako"
export OF_NO_TREBLE_COMPATIBILITY_CHECK="1"
export OF_OTA_RES_DECRYPT="1"
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"
export OF_USE_NEW_MAGISKBOOT="1"
export TARGET_ARCH="arm64"
export TW_DEFAULT_LANGUAGE="en"
export FOX_R11="1"
export FOX_ADVANCED_SECURITY="1"
export FOX_BUILD_TYPE="Stable"
export FOX_VERSION="R11.0"
export USE_CCACHE="1"

# lzma
[ "$FOX_USE_LZMA_COMPRESSION" = "1" ] && export LZMA_RAMDISK_TARGETS="recovery"

# A/B devices
[ "$OF_AB_DEVICE" = "1" ] && export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"

# magiskboot
[ "$OF_USE_MAGISKBOOT_FOR_ALL_PATCHES" = "1" ] && export OF_USE_MAGISKBOOT="1"

# compile it
for i in $*; do
    TARGET_DEVICE="$i"
    case $TARGET_DEVICE in
        a3y17lte)
            export TARGET_DEVICE_ALT="a3y17lte, a3y17ltexc, a3y17ltexx, a3y17ltelk"
        ;;
        a6lte)
            export TARGET_DEVICE_ALT="a6lte"
        ;;
        j5y17lte)
            export TARGET_DEVICE_ALT="j5y17lte, j5y17ltexx, j5y17ltextc"
        ;;
        j6lte)
            export TARGET_DEVICE_ALT="j6lte, j6ltecis, j6ltexx, j6lteub, j6lteins, j6ltedtvvj, j6ltekx, j6ltedx"
        ;;
        j7velte)
            export TARGET_DEVICE_ALT="j7velte, j7veltedx, j7veltedd, j7veltekk"
        ;;
        j7xelte)
            export TARGET_DEVICE_ALT="j7xelte, j7xeltexx, j7xeltekk, j7xeltedx, j7xelteub"
        ;;
        j7y17lte)
            export TARGET_DEVICE_ALT="j7y17lte, j7y17ltexx, j7y17ltextc"
        ;;
        on7xelte)
            export TARGET_DEVICE_ALT="on7xelte, on7xeltedd, on7xeltekl,on7xeltekk, on7xelteks, on7xelteub, on7xeltezt"
        ;;
    esac
    . build/envsetup.sh
    lunch omni_`echo $i`-eng
    mka recoveryimage -j`nproc`
done
