#
# This simple makefile downloads the latest version of android SDK and NDK
#	and extracts and installs it.
#



ANDROID_SDK_VERSION := r22.2.1
ANDROID_SDK_TGZ := downloads/android-sdk_$(ANDROID_SDK_VERSION)-linux.tgz
ANDROID_SDK_DOWNLOAD_LOCATION := http://dl.google.com/android/android-sdk_$(ANDROID_SDK_VERSION)-linux.tgz
ANDROID_SDK_LOCATION := android-sdk-linux

ANDROID_NDK_VERSION := r9
ANDROID_NDK_BZ2 := downloads/android-ndk-$(ANDROID_NDK_VERSION)-linux-x86_64.tar.bz2
ANDROID_NDK_DOWNLOAD_LOCATION := http://dl.google.com/android/ndk/android-ndk-$(ANDROID_NDK_VERSION)-linux-x86_64.tar.bz2
ANDROID_NDK_LOCATION := android-ndk-$(ANDROID_NDK_VERSION)

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
	@tar zxf $(ANDROID_SDK_TGZ)
	touch $@

extract_ndk : $(ANDROID_NDK_LOCATION)/.extracted

$(ANDROID_NDK_LOCATION)/.extracted : download_ndk
	@echo Extracting Android SDK
	@tar jxf $(ANDROID_NDK_BZ2)
	touch $@

download : download_sdk download_ndk

download_sdk : $(ANDROID_SDK_TGZ)

download_ndk : $(ANDROID_NDK_BZ2)

$(ANDROID_SDK_TGZ) : downloads/.sentinel
	@echo Downloading Android SDK
	@wget -nv -O $@ $(ANDROID_SDK_DOWNLOAD_LOCATION)
	@touch $@

$(ANDROID_NDK_BZ2) : downloads/.sentinel
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
