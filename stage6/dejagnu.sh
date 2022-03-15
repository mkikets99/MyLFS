#!/usr/bin/env bash
# DejaGNU Stage 6
# ~~~~~~~~~~~~~~~
set -e

cd /sources

eval "$(grep DEJAGNU $PACKAGE_LIST)"
PKG_DEJAGNU=$(basename $PKG_DEJAGNU)

tar -xf $PKG_DEJAGNU
cd ${PKG_DEJAGNU%.tar*}

mkdir build
cd       build

../configure --prefix=/usr
makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi

make install
install -dm755  /usr/share/doc/dejagnu-1.6.3
install -m644   doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3

if $RUN_TESTS
then
    set +e
    make check &> $TESTLOG_DIR/dejagnu.log
    set -e
fi

cd /sources
rm -rf ${PKG_DEJAGNU%.tar*}

