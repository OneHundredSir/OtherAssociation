5）下载libcurl源码，运行libcurl初始化脚本

git clone https://github.com/bagder/curl.git

cd curl

./buildconf



6）编译simulator版本，首先需要设置诸多编译环境，本人mac环境是xcode 6.4， sdk是8.4为例

export IPHONEOS_DEPLOYMENT_TARGET="10.1"

export CC="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang"

export CFLAGS="-arch i386 -pipe -Os -gdwarf-2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator10.1.sdk"

export LDFLAGS="-arch i386 –isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator10.1.sdk"

./configure --disable-shared --enable-static --host="i386-apple-darwin" --prefix=/usr/local --with-darwinssl --enable-threaded-resolver

make -j `sysctl -n hw.logicalcpu_max

cp lib/.libs/libcurl.a ~/Desktop/libcurl-i386.a

make clean



7）编译arm版本稍有不同

export IPHONEOS_DEPLOYMENT_TARGET="10.1"

export CC="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang"

export CFLAGS="-arch [ARCH] -pipe -Os -gdwarf-2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS10.1.sdk"

export LDFLAGS="-arch [ARCH] -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS10.1.sdk"

./configure --disable-shared --enable-static --host="[ARCH]-apple-darwin" --prefix=/usr/local --with-darwinssl --enable-threaded-resolver

make -j `sysctl -n hw.logicalcpu_max`

cp lib/.libs/libcurl.a ~/Desktop/libcurl-[ARCH].a

make clean

此处特别注意[ARCH]代表armv7,armvs7和arm64，但是[ARCH]-apple-darwin这里却不存在arm64-apple-darwin，需要改成arm-apple-darwin即可config通过。



8）合并libcurl

cd ~/Desktop

$ lipo -create -output libcurl.a libcurl*
