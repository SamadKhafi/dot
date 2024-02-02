FIRMWARE_FILE = firmware.bin
FLASH_ADDRESS = 0x8000000

DEBUG_DIR = ./build/Debug
RELEASE_DIR = ./build/Release

TOOLCHAIN_FILE = arm-none-eabi-gcc.cmake

FLASH_TOOL = st-flash
CMAKE = cmake

.PHONY: all debug build clean flash dflash erase

default all: build

debug: BUILD_TYPE = Debug
debug: BUILD_DIR = $(DEBUG_DIR)
debug: build

BUILD_TYPE = Release
BUILD_DIR = $(RELEASE_DIR)

build:
	@$(CMAKE) -DCMAKE_TOOLCHAIN_FILE=$(TOOLCHAIN_FILE) -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -S . -B $(BUILD_DIR)
	@$(CMAKE) --build $(BUILD_DIR) -- -j4

clean:
	rm -rf $(DEBUG_DIR)/*
	rm -rf $(RELEASE_DIR)/*

flash:
	@$(FLASH_TOOL) --reset write $(RELEASE_DIR)/$(FIRMWARE_FILE) $(FLASH_ADDRESS)

dflash:
	@$(FLASH_TOOL) --reset write $(DEBUG_DIR)/$(FIRMWARE_FILE) $(FLASH_ADDRESS)

erase:
	@$(FLASH_TOOL) erase
