# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit qt4-r2 scons-utils toolchain-funcs

RESTRICT="nomirror"
IUSE=""

DESCRIPTION="A mixer app for jack"
HOMEPAGE="http://www.arnoldarts.de/drupal/?q=JackMix"
SRC_URI="http://www.arnoldarts.de/downloads/jackmix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${RDEPEND}
		dev-util/pkgconfig"
RDEPEND="media-sound/jack-audio-connection-kit
		x11-libs/qt-core
		x11-libs/qt-gui
		x11-libs/qt-xmlpatterns
		>=media-libs/liblo-0.23"

PATCHES=( "${FILESDIR}/${P}-scons-env.patch" )

src_configure() {
	myesconsargs=(
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		CXXFLAGS="$(tc-getCXXFLAGS)"
	)
}


src_compile() {
	escons
}

src_install() {
	dobin jackmix/jackmix
	dodoc AUTHORS ChangeLog
	make_desktop_entry "${PN}" "JackMix" Audio "AudioVideo;Audio;Mixer"
}
