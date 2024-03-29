common_imx_dirs := libsensors libgps lights wlan
mx5x_dirs := $(common_imx_dirs) mx5x/audio mx5x/libgralloc mx5x/hwcomposer mx5x/libcamera mx5x/power
mx6_dirs := $(common_imx_dirs) alsa mx6/libgralloc_wrapper mx6/hwcomposer mx6/libcamera mx6/power

ifeq ($(TARGET_BOARD_PLATFORM),imx6)
  include $(call all-named-subdir-makefiles,$(mx6_dirs))
else
  ifeq ($(TARGET_BOARD_PLATFORM),imx5x)
    include $(call all-named-subdir-makefiles,$(mx5x_dirs))
  endif
endif
