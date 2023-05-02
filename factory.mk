#
# Copyright (C) 2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FACTORY_PATH := device/khadas/kvim1s/factory

PRODUCT_UPGRADE_OUT := $(PRODUCT_OUT)/upgrade
PACKAGE_CONFIG_FILE := $(PRODUCT_UPGRADE_OUT)/image.cfg
AML_IMAGE_TOOL := $(HOST_OUT_EXECUTABLES)/aml_image_packer$(HOST_EXECUTABLE_SUFFIX)

INSTALLED_AML_UPGRADE_PACKAGE_TARGET := $(PRODUCT_OUT)/aml_upgrade_package.img

define aml-symlink-file
	$(hide) ln -sf $(shell readlink -f $(1)) $(PRODUCT_UPGRADE_OUT)/$(strip $(if $(2), $(2), $(notdir $(1))))
endef

NEEDED_IMAGES := \
    logo.img \
    boot.img \
    super.img \
    vbmeta.img \
    vbmeta_system.img \
    vendor_boot.img \
    dtbo.img

$(INSTALLED_AML_UPGRADE_PACKAGE_TARGET): $(addprefix $(PRODUCT_OUT)/,$(NEEDED_IMAGES)) $(AML_IMAGE_TOOL)
	$(hide) mkdir -p $(PRODUCT_UPGRADE_OUT)
#ifneq ("$(wildcard $(FACTORY_PATH)/u-boot.bin.usb.signed)","")
	$(hide) $(call aml-symlink-file, $(FACTORY_PATH)/DDR.USB)
	$(hide) $(call aml-symlink-file, $(FACTORY_PATH)/aml_sdc_burn.UBOOT)
	$(hide) $(call aml-symlink-file, $(FACTORY_PATH)/bootloader.img)
	$(hide) $(call aml-symlink-file, $(FACTORY_PATH)/odm_ext_a.PARTITION)
	$(hide) $(call aml-symlink-file, $(FACTORY_PATH)/oem_a.PARTITION)
#else ifneq ("$(wildcard vendor/khadas/kvim1s/radio/bootloader.img)","")
#	$(hide) $(call aml-symlink-file, vendor/khadas/kvim1s/radio/bootloader.img, u-boot.bin)
#else
#	$(error "no u-boot.bin found in $(FACTORY_PATH)")
#endif
	$(hide) $(call aml-symlink-file, $(PRODUCT_OUT)/logo.img)
	$(hide) $(call aml-symlink-file, $(FACTORY_PATH)/aml_sdc_burn.ini)
	$(hide) $(call aml-symlink-file, $(FACTORY_PATH)/usb_flow.aml)
	$(hide) $(call aml-symlink-file, $(FACTORY_PATH)/image.cfg)
	$(hide) $(call aml-symlink-file, $(FACTORY_PATH)/platform.conf)
	$(hide) $(call aml-symlink-file, $(PRODUCT_OUT)/boot.img)
	$(hide) $(call aml-symlink-file, $(PRODUCT_OUT)/recovery.img)
	$(hide) $(call aml-symlink-file, $(INSTALLED_DTBIMAGE_TARGET), dtb.img)
	$(hide) $(call aml-symlink-file, $(PRODUCT_OUT)/dtbo.img)
	$(hide) $(call aml-symlink-file, $(PRODUCT_OUT)/super.img)
	$(hide) $(call aml-symlink-file, $(PRODUCT_OUT)/vbmeta.img)
	$(hide) $(call aml-symlink-file, $(PRODUCT_OUT)/vbmeta_system.img)
	$(hide) $(call aml-symlink-file, $(PRODUCT_OUT)/vendor_boot.img)
	$(hide) $(AML_IMAGE_TOOL) -r $(PACKAGE_CONFIG_FILE) $(PRODUCT_UPGRADE_OUT)/ $@
	$(hide) rm -rf $(PRODUCT_UPGRADE_OUT)
	$(hide) echo " $@ created"

.PHONY: aml_upgrade
aml_upgrade: $(INSTALLED_AML_UPGRADE_PACKAGE_TARGET)
