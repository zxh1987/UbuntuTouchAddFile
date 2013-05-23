#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/soc/imx6wand.mk
include device/fsl/wandboard/build_id.mk
include device/fsl/imx6/wandboard/WandBoardConfigComm.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk

BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0:dev=hdmi,1280x720M@60,if=RGB24,bpp=32 video=mxcfb1:off video=mxcfb2:off fbmem=28M vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=freescale


ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0 video=mxcfb1:off video=mxcfb2:off fbmem=10M fb0base=0x27b00000 vmalloc=400M androidboot.console=ttymxc0  mtdparts=gpmi-nand:20m(bootloader),20m(bootimg),20m(recovery),-(root) gpmi_debug_init ubi.mtd=3 androidboot.hardware=freescale
endif


TARGET_BOOTLOADER_CONFIG := 6solo:wandboard_android_solo_config 6dl:wandboard_android_dl_config


