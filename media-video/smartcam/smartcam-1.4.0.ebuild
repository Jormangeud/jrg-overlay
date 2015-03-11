# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils linux-mod

DESCRIPTION="Smartcam kernel module driver"
HOMEPAGE="http://smartcam.sourceforge.net"
SRC_URI="mirror://sourceforge/smartcam/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${P}/driver_src

MODULE_NAMES="smartcam(misc)"
BUILD_PARAMS='-C "${KV_OUT_DIR}" M="${PWD}"'
BUILD_TARGETS="modules"

src_prepare() {
  if kernel_is gt 2 6 28; then
    if kernel_is le 2 6 32; then
      epatch "${FILESDIR}"/${PN}.patch
    fi
  fi
  if kernel_is gt 2 6 32; then
    epatch "${FILESDIR}"/${PN}-2.6.34.patch
  fi
}