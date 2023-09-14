#
# Copyright (C) 2021-2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/khadas/kvim1s

## Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth/include
BOARD_CUSTOM_BT_CONFIG := $(DEVICE_PATH)/bluetooth/vnd_kvim1s.txt
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

## Bootloader
TARGET_BOOTLOADER_BOARD_NAME := kvim1s

## DTB
TARGET_DTB_NAME := kvim1s
TARGET_DTBO_NAME := android_overlay_dt

#TARGET_KERNEL_CONFIG := meson64_gki_module_config

## Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

## Wi-Fi
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_AP := "/vendor/etc/wifi/buildin/fw_fw_bcm4356a2_ag_apsta.bin"
WIFI_DRIVER_FW_PATH_STA := "/vendor/etc/wifi/buildin/fw_bcm4356a2_ag.bin"
WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/dhd/parameters/firmware_path"
WPA_SUPPLICANT_VERSION := VER_0_8_X

## Include the common tree BoardConfig makefile
include device/amlogic/ne-common/BoardConfigCommon.mk

## Include the proprietary BoardConfig makefile
include vendor/khadas/kvim1s/BoardConfigVendor.mk
