# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit scons-utils toolchain-funcs vcs-snapshot

TAG="bc11af8ce3771f502be93f6e19c0931db3d434bb"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_BRANCH="qt5"
	EGIT_REPO_URI="https://github.com/kampfschlaefer/jackmix.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/kampfschlaefer/jackmix/archive/${TAG}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
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
	>=dev-qt/qtcore-5.3:5
	>=dev-qt/qtgui-5.3:5
	>=dev-qt/qtwidgets-5.3:5
	>=dev-qt/qtxml-5.3:5
	>=media-libs/liblo-0.23
	media-libs/alsa-lib
	media-sound/lash
	"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}-0.6-scons-env.patch" )

src_configure() {
	MYSCONS=(
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		CXXFLAGS="${CXXFLAGS} -fPIC"
		LDFLAGS="${LDFLAGS} -fPIC"
	)
}


src_compile() {
	escons "${MYSCONS[@]}"
}

src_install() {
	dobin jackmix/jackmix
	dodoc AUTHORS ChangeLog
	make_desktop_entry "${PN}" "JackMix" Audio "AudioVideo;Audio;Mixer"
}
