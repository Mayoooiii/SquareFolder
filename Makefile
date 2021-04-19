TARGET := iphone:latest:latest
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e
GO_EASY_ON_ME = 1

THEOS_DEVICE_IP=192.168.168.121
THEOS_DEVICE_PORT=22

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SquareFolder

SquareFolder_FILES = Tweak.m
SquareFolder_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
