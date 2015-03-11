#!/bin/bash

#PYRO_URI="http://pyroscope.googlecode.com/svn/trunk/pyrocore/docs/rtorrent-extended/patches"
PYRO_URI="https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches"
PYRO_FILES="\
command_pyroscope.cc \
ps-ui_pyroscope_0.8.8.patch \
pyroscope.patch \
ui_pyroscope.cc \
ui_pyroscope.h \
ui_pyroscope.patch"



for f in $PYRO_FILES; do
    wget -nc $PYRO_URI/$f
done

