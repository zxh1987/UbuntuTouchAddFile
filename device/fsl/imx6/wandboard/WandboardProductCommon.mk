PRODUCT_COPY_FILES += \
	device/fsl/imx6/wandboard/required_hardware.xml:system/etc/permissions/required_hardware.xml \
	device/fsl/imx6/wandboard/init.rc:root/init.rc \
	device/fsl/imx6/wandboard/init.wandboard.rc:root/init.wandboard.rc \
	device/fsl/imx6/wandboard/vold.fstab:system/etc/vold.fstab \
	device/fsl/imx6/wandboard/gpsreset.sh:system/etc/gpsreset.sh

# GPU files

DEVICE_PACKAGE_OVERLAYS := device/fsl/imx6/wandboard/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_AAPT_CONFIG += xlarge large tvdpi hdpi

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
	frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

#        frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \

PRODUCT_COPY_FILES += \
	device/fsl/imx6/wandboard/firmware/brcm/brcmfmac-sdio.bin:system/etc/firmware/brcm/brcmfmac-sdio.bin \
	device/fsl/imx6/wandboard/firmware/brcm/brcmfmac-sdio.txt:system/etc/firmware/brcm/brcmfmac-sdio.txt \
	device/fsl/imx6/wandboard/firmware/brcm/bcm4329.hcd:system/etc/firmware/brcm/bcm4329.hcd \
	device/fsl/imx6/wandboard/rc.wifi:system/bin/wifi/rc.wifi

# Bluetooth support
PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
        system/bluetooth/data/main.nonsmartphone.conf:system/etc/bluetooth/main.conf


# for PDK build, include only when the dir exists
# too early to use $(TARGET_BUILD_PDK)
ifneq ($(wildcard packages/wallpapers/LivePicker),)
PRODUCT_COPY_FILES += \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml
endif
