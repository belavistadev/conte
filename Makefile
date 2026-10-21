# Fail a recipe when xcodebuild fails, even when piped into xcbeautify.
SHELL = /bin/bash
.SHELLFLAGS = -o pipefail -c

# Product
APP = Conte
SCHEME = $(APP)
PROJECT = $(SCHEME).xcodeproj
CONFIGURATION ?= Debug

# Bundle ID. Contributors signing with their own team (see Signing.xcconfig)
# need one of their own: make ibuild TARGET="MicroMac" BUNDLE_ID=com.me.Conte
BUNDLE_ID ?= br.com.carahiba.Conte

# Development
BUILD_DIR = .build
PRODUCTS_DIR = $(BUILD_DIR)/Build/Products
MACOS_APP_PATH = $(PRODUCTS_DIR)/$(CONFIGURATION)/$(APP).app
IOS_APP_PATH = $(PRODUCTS_DIR)/$(CONFIGURATION)-iphoneos/$(APP).app

# Physical iOS/iPadOS device, by name or UDID.
# List the connected ones with `make devices`.
TARGET ?=

XCODEBUILD = xcodebuild \
	-project $(PROJECT) \
	-scheme $(SCHEME) \
	-configuration $(CONFIGURATION) \
	-derivedDataPath $(BUILD_DIR) \
	PRODUCT_BUNDLE_IDENTIFIER=$(BUNDLE_ID)

# Logging: use xcbeautify when it's installed, raw output otherwise.
ifneq ($(shell command -v xcbeautify),)
	FORMAT = xcbeautify --disable-logging
else
	FORMAT = cat
endif

# macOS

build:
	@echo Building for macOS...
	@$(XCODEBUILD) build \
		-destination "platform=macOS" \
		| $(FORMAT)

run: build
	@echo Launching...
	@open "$(MACOS_APP_PATH)"

# iOS/iPadOS (physical devices only)

check-target:
ifeq ($(strip $(TARGET)),)
	@echo 'Missing TARGET. Usage: make ibuild TARGET="<Your device name>"'
	@echo 'Connected devices:'
	@xcrun devicectl list devices
	@exit 1
endif

ibuild: check-target
	@echo Building for "$(TARGET)"...
	@$(XCODEBUILD) build \
		-destination "platform=iOS,name=$(TARGET)" \
		-allowProvisioningUpdates \
		| $(FORMAT)

irun: ibuild
	@echo Installing on "$(TARGET)"...
	@xcrun devicectl device install app \
		--device "$(TARGET)" \
		"$(IOS_APP_PATH)"
	@echo Launching on "$(TARGET)"...
	@xcrun devicectl device process launch \
		--device "$(TARGET)" \
		$(BUNDLE_ID)

devices:
	@xcrun devicectl list devices

# Housekeeping

clean:
	@echo Cleaning...
	@$(XCODEBUILD) clean | $(FORMAT)
	@rm -rf $(BUILD_DIR)

.PHONY: build run check-target ibuild irun devices clean
