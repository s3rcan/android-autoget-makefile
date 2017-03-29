#
# This simple makefile downloads the latest version of android SDK and NDK
#	and extracts and installs it.
#


ANDROID_SDK_VERSION := r25.2.3
ANDROID_SDK_ZIP := downloads/tools_$(ANDROID_SDK_VERSION)-linux.zip
ANDROID_SDK_DOWNLOAD_LOCATION := https://dl.google.com/android/repository/tools_$(ANDROID_SDK_VERSION)-linux.zip
ANDROID_SDK_LOCATION := android-sdk

ANDROID_NDK_VERSION := r10e
ANDROID_NDK_ZIP := downloads/android-ndk-$(ANDROID_NDK_VERSION)-linux-x86_64.tar.bz2
ANDROID_NDK_DOWNLOAD_LOCATION := https://dl.google.com/android/repository/android-ndk-$(ANDROID_NDK_VERSION)-linux-x86_64.zip
ANDROID_NDK_LOCATION := android-ndk

define EXPECT_SCRIPT
set timeout -1                                                  \n\
                                                                \n\
spawn android-sdk-linux/tools/android update sdk --no-ui        \n\
                                                                \n\
expect {                                                        \n\
    \"\[y\\/n\]: \" {                                           \n\
        send \"y\\\r\"                                          \n\
        expect \"y\\\r\"                                        \n\
        exp_continue                                            \n\
    }                                                           \n\
}                                                               \n\

endef

install_tools : extract_sdk
	echo "$(EXPECT_SCRIPT)" > tmp.exp
	expect -f tmp.exp
	rm tmp.exp

extract : extract_sdk extract_ndk

extract_sdk : $(ANDROID_SDK_LOCATION)/.extracted

$(ANDROID_SDK_LOCATION)/.extracted : download_sdk
	@echo Extracting Android SDK
	@unzip $(ANDROID_SDK_ZIP) -d $(ANDROID_SDK_LOCATION)
	touch $@

extract_ndk : $(ANDROID_NDK_LOCATION)/.extracted

$(ANDROID_NDK_LOCATION)/.extracted : download_ndk
	@echo Extracting Android SDK
	@unzip $(ANDROID_NDK_ZIP) -d $(ANDROID_NDK_LOCATION)
	touch $@

download : download_sdk download_ndk

download_sdk : $(ANDROID_SDK_ZIP)

download_ndk : $(ANDROID_NDK_ZIP)

$(ANDROID_SDK_ZIP) : downloads/.sentinel
	@echo Downloading Android SDK
	@wget -nv -O $@ $(ANDROID_SDK_DOWNLOAD_LOCATION)
	@touch $@

$(ANDROID_NDK_ZIP) : downloads/.sentinel
	@echo Downloading Android NDK
	@wget -nv -O $@ $(ANDROID_NDK_DOWNLOAD_LOCATION)
	@touch $@

%/.sentinel :
	@mkdir -p $(dir $@)
	@touch $@

clean :
	@rm -rf $(ANDROID_SDK_LOCATION)
	@rm -rf $(ANDROID_NDK_LOCATION)
	@rm -rf downloads
