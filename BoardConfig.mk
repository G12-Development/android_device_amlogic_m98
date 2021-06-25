#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

include vendor/askey/deadpool/BoardConfigVendor.mk

include device/amlogic/g12-common/BoardConfigCommon.mk

DEVICE_PATH := device/askey/deadpool

## Bootloader
TARGET_BOOTLOADER_BOARD_NAME := deadpool

## DTB
TARGET_DTB_NAME := g12a_s905y2_deadpool
