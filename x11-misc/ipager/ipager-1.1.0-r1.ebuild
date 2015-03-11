# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=4
inherit scons-utils eutils toolchain-funcs

DESCRIPTION="A themable desktop pager for fluxbox and other window managers"
HOMEPAGE="http://www.useperl.ru/ipager/index.en.html"
SRC_URI="http://www.useperl.ru/ipager/src/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xinerama"

RDEPEND="
	media-libs/imlib2[X]
	x11-libs/libXmu
	xinerama? ( x11-libs/libXinerama )
	"

DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-scons_imlib2.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-gcc47.patch
	epatch "${FILESDIR}"/${P}-scons_flags.patch
	epatch "${FILESDIR}"/${P}-scons_2.1.0.patch
	epatch "${FILESDIR}"/${P}-scons_X11_path.patch
}

src_configure() {
	# set CFLAGS used in /etc/make.conf correctly
	echo "CFLAGS=[`for i in ${CFLAGS[@]}; do printf "%s \'$i"\',; done`] " \
		| sed -e "s:,]: ]:" >> "${S}"/user.opts

	# set CXXFLAGS used in /etc/make.conf correctly
	local FILTERED_CXXFLAGS="`for i in ${CXXFLAGS[@]}; do printf "%s \'$i"\',; done`"
	echo "CXXFLAGS=[${FILTERED_CXXFLAGS}]" | sed -e "s:,]: ]:" >> "${S}"/user.opts

	# set LDFLAGS used in /etc/make.conf correctly
	local FILTERED_LDFLAGS="`for i in ${LDFLAGS[@]}; do printf "%s \'$i"\',; done`"
	echo "LDFLAGS=[${FILTERED_LDFLAGS}]" | sed -e "s:,]: ]:" >> "${S}"/user.opts
	use xinerama && echo "xinerama=1" >> "${S}"/user.opts

}

src_compile() {
	escons CC="$(tc-getCC)"
}

src_install() {
	exeinto /usr/bin
	doexe ipager
	dodoc ToDo ChangeLog README
	dodoc themes/*.conf
}
