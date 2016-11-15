#!/bin/sh
 
#此处请填写对应的SDK版本号
$SDKVERSION=""
 
#创建文件夹 bin 存放静态库文件  include 存放头文件
mkdir ../bin
mkdir ../include
 
#i386 编译
export IPHONEOS_DEPLOYMENT_TARGET="7.0"
export CC="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang"
export CFLAGS="-arch i386 -pipe -Os -gdwarf-2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator${SDKVERSION}.sdk"
export LDFLAGS="-arch i386 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator${SDKVERSION}.sdk"
./configure --disable-shared --enable-static --without-ssl --host="i386-apple-darwin"
make -j `sysctl -n hw.logicalcpu_max`
cp lib/.libs/libcurl.a ../bin/libcurl-i386.a
 
make clean
 
echo "################################i386编译完成#####################################"
 
#x86_64编译
 
export IPHONEOS_DEPLOYMENT_TARGET="7.0"
export CC="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang"
export CFLAGS="-arch x86_64 -pipe -Os -gdwarf-2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator${SDKVERSION}.sdk"
export LDFLAGS="-arch x86_64 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator${SDKVERSION}.sdk"
./configure --disable-shared --enable-static --without-ssl --host="i386-apple-darwin"
make -j `sysctl -n hw.logicalcpu_max`
cp lib/.libs/libcurl.a ../bin/libcurl-x86.a
make clean
 
 
#armv7编译
echo "#################################X86_64编译完成###################################"
 
export IPHONEOS_DEPLOYMENT_TARGET="7.0"
export CC="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang"
export CFLAGS="-arch armv7 -pipe -Os -gdwarf-2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS${SDKVERSION}.sdk"
export LDFLAGS="-arch armv7 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS${SDKVERSION}.sdk"
./configure --disable-shared --enable-static --without-ssl --host="x86_64-apple-darwin"
make -j `sysctl -n hw.logicalcpu_max`
cp lib/.libs/libcurl.a ../bin/libcurl-armv7.a
make clean
 
echo "##################################armv7编译完成###################################"
 
#armv7s编译
export IPHONEOS_DEPLOYMENT_TARGET="7.0"
export CC="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang"
export CFLAGS="-arch armv7s -pipe -Os -gdwarf-2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS${SDKVERSION}.sdk"
export LDFLAGS="-arch armv7s -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS${SDKVERSION}.sdk"
./configure --disable-shared --enable-static --without-ssl --host="x86_64-apple-darwin"
make -j `sysctl -n hw.logicalcpu_max`
cp lib/.libs/libcurl.a ../bin/libcurl-armv7s.a
make clean
 
echo "#################################armv7s编译完成###################################"
 
#arm64编译
export IPHONEOS_DEPLOYMENT_TARGET="7.0"
export CC="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang"
export CFLAGS="-arch arm64 -pipe -Os -gdwarf-2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS${SDKVERSION}.sdk"
export LDFLAGS="-arch arm64 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS${SDKVERSION}.sdk"
./configure --disable-shared --enable-static --without-ssl --host="x86_64-apple-darwin"
make -j `sysctl -n hw.logicalcpu_max`
cp lib/.libs/libcurl.a ../bin/libcurl-arm64.a
make clean
 
echo "##################################arm64编译完成###################################"
 
#将头文件拷贝出来
 
cp -r include/curl ../include
 
 
#合成包
 
cd ..
cd bin
lipo -create -output libcurl.a libcurl*
 
echo "##################################打包完成###################################"
