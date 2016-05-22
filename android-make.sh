#===========================================================================================================================
DEV_PREFIX=/opt
ANDROID_NDK=${DEV_PREFIX}/ndk
CROSS_COMPILE=arm-linux-androideabi
ANDROID_PREFIX=/tmp/chain
SYSROOT=${ANDROID_NDK}/platforms/android-17/arch-arm
CROSS_PATH=${ANDROID_PREFIX}/bin/${CROSS_COMPILE}
CPP=${CROSS_PATH}-cpp
AR=${CROSS_PATH}-ar
AS=${CROSS_PATH}-as
NM=${CROSS_PATH}-nm
export CC=${CROSS_PATH}-gcc
CXX=${CROSS_PATH}-g++
LD=${CROSS_PATH}-ld
RANLIB=${CROSS_PATH}-ranlib
PREFIX=${DEV_PREFIX}/android-bin
PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
CFLAGS="-UHAVE_LOCALE_H --sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${ANDROID_PREFIX}/include -I${DEV_PREFIX}/android/bionic "
CPPFLAGS="${CFLAGS}"
LDFLAGS="${LDFLAGS} -L${SYSROOT}/usr/lib -L${ANDROID_PREFIX}/lib"
./configure --without-tests --host=${CROSS_COMPILE} --with-sysroot=${SYSROOT} --prefix=${PREFIX} "$@" && make
if [ -f lib/libncurses.[a] ];then
  mkdir /data
  mkdir /data/local
  mkdir /data/local/tmp
  mkdir /data/local/tmp/lib
  mkdir /data/local/tmp/lib/include
  cp include/term.h /data/local/tmp/lib/include
  cp include/curses.h /data/local/tmp/lib/include
  cp include/unctrl.h /data/local/tmp/lib/include
  cp include/termcap.h /data/local/tmp/lib/include
  cp include/ncurses_dll.h /data/local/tmp/lib/include
  cp lib/libform.a /data/local/tmp/lib
  cp lib/libform_g.a /data/local/tmp/lib
  cp lib/libmenu.a /data/local/tmp/lib
  cp lib/libmenu_g.a /data/local/tmp/lib
  cp lib/libncurses.a /data/local/tmp/lib
  cp lib/libncurses++.a /data/local/tmp/lib
  cp lib/libncurses_g.a /data/local/tmp/lib
  cp lib/libpanel.a /data/local/tmp/lib
  cp lib/libpanel_g.a /data/local/tmp/lib
  echo "Done building ncurses for android. Output in /data/local/tmp/lib and /data/local/tmp/lib/include"
else
  echo Build failed.
fi
