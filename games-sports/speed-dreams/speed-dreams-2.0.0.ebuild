# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/speed-dreams/speed-dreams-1.4.0.ebuild,v 1.8 2012/03/16 20:04:54 tupone Exp $

EAPI=3
inherit autotools eutils versionator games cmake-utils

DESCRIPTION="A fork of the famous open racing car simulator TORCS"
HOMEPAGE="http://speed-dreams.sourceforge.net/"
SRC_URI="mirror://sourceforge/speed-dreams/${PN}-src-base-${PV}-r4687.tar.xz
	mirror://sourceforge/speed-dreams/${PN}-src-wip-cars-and-tracks-${PV}-r4687.tar.xz
	mirror://sourceforge/speed-dreams/${PN}-src-unmaintained-${PV}-r4687.tar.xz
	mirror://sourceforge/speed-dreams/${PN}-src-more-hq-cars-and-tracks-${PV}-r4687.tar.xz
	mirror://sourceforge/speed-dreams/${PN}-src-hq-cars-and-tracks-${PV}-r4687.tar.xz
	"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="xrandr"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/freeglut
	media-libs/openal
	media-libs/freealut
	x11-libs/libX11
	x11-libs/libXxf86vm
	xrandr? ( x11-libs/libXrandr )
	sys-libs/zlib
	>=net-libs/enet-1.2
	>=media-libs/libpng-1.2.40"
DEPEND="${RDEPEND}
	>=media-libs/plib-1.8.3
	x11-proto/xproto
	x11-libs/libXext
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXt
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXrender
	xrandr? ( x11-proto/randrproto )"

S=${WORKDIR}

src_configure() {
	mycmakeargs+=(
	'-DOPTION_OFFICIAL_ONLY:BOOL=ON'
	'-DOPTION_DEBUG:BOOL=OFF'
	'-DSD_BINDIR:STRING=games/bin'
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	newicon data/data/icons/icon.png ${PN}.png
	make_desktop_entry ${PN} "Speed Dreams"

	prepgamesdirs
}
