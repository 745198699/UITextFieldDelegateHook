THEOS_DEVICE_IP = 172.20.17.4
ARCHS = arm64
TARGET = iphone:latest:8.0

include theos/makefiles/common.mk

TWEAK_NAME = UIDelegateHook
UIDelegateHook_FILES = Tweak.xm
UIDelegateHook_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk


