#!/bin/bash

PWD=$(pwd)
PYRO_DIR="ps"
PYRO_URI="https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches"
PYRO_FILES="\
command_pyroscope.cc \
ps-info-pane-xb-sizes_all.patch \
ps-item-stats-human-sizes_all.patch \
ps-ssl_verify_host_all.patch \
ps-throttle-steps_all.patch \
ps-ui_pyroscope_all.patch \
pyroscope.patch \
ui_pyroscope.cc \
ui_pyroscope.h \
ui_pyroscope.patch"

mkdir $PYRO_DIR
cd $PYRO_DIR

for f in $PYRO_FILES; do
    wget -q -nc $PYRO_URI/$f
done

cd $PWD
