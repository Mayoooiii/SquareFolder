TARGET := iphone:latest:latest
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SquareFolder

SquareFolder_FILES = Tweak.m
SquareFolder_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
