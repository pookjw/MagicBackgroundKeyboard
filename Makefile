FINALPACKAGE=1
TARGET := iphone:clang:latest
THEOS_PACKAGE_SCHEME = rootless
export ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MagicBackgroundKeyboard
$(TWEAK_NAME)_CFLAGS = -fno-objc-arc -fno-objc-weak -Wno-module-import-in-extern-c -Wno-unused-variable -Wno-parentheses -std=c++2b
$(TWEAK_NAME)_FRAMEWORKS = Foundation UIKit
$(TWEAK_NAME)_FILES = init.mm

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/tool.mk
