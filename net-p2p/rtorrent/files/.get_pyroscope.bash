#!/bin/bash

umask 0012

PWD=$(pwd)
PYRO_DIR="ps"
PYRO_URI="https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches"
PYRO_FILES="\
backport_0.9.6_algorithm_median.patch \
command_pyroscope.cc \
ps-ui_pyroscope_all.patch \
ps-view-filter-by_all.patch \
pyroscope.patch \
ui_pyroscope.cc \
ui_pyroscope.h \
ui_pyroscope.patch"

mkdir -p $PYRO_DIR
pushd $PYRO_DIR

for f in $PYRO_FILES; do
    wget -q -nc $PYRO_URI/$f
done

popd

patch -p0 < .ps_fix-ui_pyroscope-patch-0.9.7.patch

# get master patch
# wget https://github.com/rakshasa/rtorrent/compare/v0.9.7...master.diff -O rtorrent-0.9.7...master-for-pyroscope.diff
