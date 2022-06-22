#!/bin/sh
# !!!!!分别编译common、render、conchRuntime 项目
# !!!!!后续可以考虑自动化编译，以下为手动编译步骤：
# 1.编译relese，debug 会比较大！！！
# 2.编译ios lib  选择 Any iOS Device (arm64,armv7)
# 3.编译sim lib  选择 模拟器 (i386,x86_x64)
# 4.以上步骤完成后可允许此脚本完成libconch.a的合成

rm -rf ./publish/nativetools/template/ios/LayaRuntime-iOS
mkdir ./publish/nativetools/template/ios/LayaRuntime-iOS
mkdir ./publish/nativetools/template/ios/LayaRuntime-iOS/libs

#—————————————————————merge static lib————————————————————————

rm -f conch/libconch.a
rm -rf armv64
rm -rf x86_64
mkdir armv64
mkdir x86_64

lipo -extract arm64 ./ThirdParty/bullet/lib/ios/libBulletDynamics.a -o armv64/libBulletDynamics.a
lipo -extract x86_64 ./ThirdParty/bullet/lib/ios/libBulletDynamics.a -o x86_64/libBulletDynamics.a

lipo -extract arm64 ./ThirdParty/bullet/lib/ios/libBulletCollision.a -o armv64/libBulletCollision.a
lipo -extract x86_64 ./ThirdParty/bullet/lib/ios/libBulletCollision.a -o x86_64/libBulletCollision.a

lipo -extract arm64 ./ThirdParty/bullet/lib/ios/libLinearMath.a -o armv64/libLinearMath.a
lipo -extract x86_64 ./ThirdParty/bullet/lib/ios/libLinearMath.a -o x86_64/libLinearMath.a


lipo -extract arm64 ./ThirdParty/freetype/lib/ios/libfreetype.a -o armv64/libfreetype.a
lipo -extract x86_64 ./ThirdParty/freetype/lib/ios/libfreetype.a -o x86_64/libfreetype.a

lipo -extract arm64 ./ThirdParty/jpeg/lib/ios/libjpeg.a -o armv64/libjpeg.a
lipo -extract x86_64 ./ThirdParty/jpeg/lib/ios/libjpeg.a -o x86_64/libjpeg.a

lipo -extract arm64 ./ThirdParty/png/lib/ios/libpng.a -o armv64/libpng.a
lipo -extract x86_64 ./ThirdParty/png/lib/ios/libpng.a -o x86_64/libpng.a

lipo -extract arm64 ./ThirdParty/websockets/lib/ios/libwebsockets.a -o armv64/libwebsockets.a
lipo -extract x86_64 ./ThirdParty/websockets/lib/ios/libwebsockets.a -o x86_64/libwebsockets.a

lipo -extract arm64 ./ThirdParty/zip/lib/ios/libzip.a -o armv64/libzip.a
lipo -extract x86_64 ./ThirdParty/zip/lib/ios/libzip.a -o x86_64/libzip.a

lipo -extract arm64 ./ThirdParty/ogg/lib/ios/libogg.a -o armv64/libogg.a
lipo -extract x86_64 ./ThirdParty/ogg/lib/ios/libogg.a -o x86_64/libogg.a

lipo -extract arm64 ./ThirdParty/ogg/lib/ios/libvorbis.a -o armv64/libvorbis.a
lipo -extract x86_64 ./ThirdParty/ogg/lib/ios/libvorbis.a -o x86_64/libvorbis.a

lipo -extract arm64 ./ThirdParty/ogg/lib/ios/libvorbisfile.a -o armv64/libvorbisfile.a
lipo -extract x86_64 ./ThirdParty/ogg/lib/ios/libvorbisfile.a -o x86_64/libvorbisfile.a

lipo -extract arm64 ./ThirdParty/zlib/lib/ios/libz.a -o armv64/libz.a
lipo -extract x86_64 ./ThirdParty/zlib/lib/ios/libz.a -o x86_64/libz.a

lipo -extract arm64 ./ThirdParty/curl/lib/ios/libcurl.a -o armv64/libcurl.a
lipo -extract x86_64 ./ThirdParty/curl/lib/ios/libcurl.a -o x86_64/libcurl.a

lipo -extract arm64 ./ThirdParty/openssl/lib/ios/libssl.a -o armv64/libssl.a
lipo -extract x86_64 ./ThirdParty/openssl/lib/ios/libssl.a -o x86_64/libssl.a


lipo -extract arm64 ./ThirdParty/openssl/lib/ios/libcrypto.a -o armv64/libcrypto.a
lipo -extract x86_64 ./ThirdParty/openssl/lib/ios/libcrypto.a -o x86_64/libcrypto.a

lipo -extract arm64 ./Conch/libs/ios/libcommon.a -o armv64/libcommon.a
lipo -extract x86_64 ./Conch/libs/ios-sim/libcommon.a -o x86_64/libcommon.a


lipo -extract arm64 ./Conch/libs/ios/librender.a -o armv64/librender.a
lipo -extract x86_64 ./Conch/libs/ios-sim/librender.a  -o x86_64/librender.a

lipo -extract arm64 ./Conch/libs/ios/libconchRuntime.a -o armv64/libconchRuntime.a
lipo -extract x86_64 ./Conch/libs/ios-sim/libconchRuntime.a -o x86_64/libconchRuntime.a


cd x86_64

libtool -static *.a -o libconch.a

cd ..

cd armv64

libtool -static *.a -o libconch.a

cd ..
lipo -create x86_64/libconch.a armv64/libconch.a -output ./publish/nativetools/template/ios/LayaRuntime-iOS/libs/libconch.a

rm -rf armv64
rm -rf x86_64

#—————————————————————copy .h————————————————————————

rm -rf ./publish/nativetools/template/ios/LayaRuntime-iOS/include
mkdir ./publish/nativetools/template/ios/LayaRuntime-iOS/include
cp -rf ./Conch/include/conchRuntime/ ./publish/nativetools/template/ios/LayaRuntime-iOS/include




