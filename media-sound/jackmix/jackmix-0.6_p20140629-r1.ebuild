# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2 scons-utils toolchain-funcs

TAG="b9f1cccb30780b1d353926aa8f97637b0fde1370"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kampfschlaefer/jackmix.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/kampfschlaefer/jackmix/archive/${TAG}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${PN}-${TAG}
fi


RESTRICT="nomirror"
IUSE=""

DESCRIPTION="A mixer app for jack"
HOMEPAGE="http://www.arnoldarts.de/jackmix/
	https://github.com/kampfschlaefer/jackmix"
#SRC_URI="https://github.com/kampfschlaefer/jackmix/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

RDEPEND=">=media-sound/jack-audio-connection-kit-0.100.0
	>=dev-qt/qtcore-4.2:4
	>=dev-qt/qtgui-4.2:4
	>=dev-qt/qtxmlpatterns-4.2:4
	>=media-libs/liblo-0.23
	media-libs/alsa-lib
	media-sound/lash
	"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}-0.6-scons-env.patch" )

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
