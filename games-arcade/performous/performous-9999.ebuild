# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CMAKE_REMOVE_MODULES="yes"
CMAKE_REMOVE_MODULES_LIST="FindALSA FindBoost FindGettext FindTiff FindZ"

inherit eutils base cmake-utils games

KEYWORDS="~amd64 ~x86"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/performous/performous.git"
	PATCHES=(
		$PATCHES
		"${FILESDIR}"/${PN}-20150719-cmake.patch
	)
	KEYWORDS=""
else
	SRC_URI="https://github.com/performous/performous/archive/${PV}.tar.gz -> ${P}.tar.gz $SRC_URI"
	PATCHES=(
		$PATCHES
		"${FILESDIR}"/${PN}-20140927-cmake.patch
	)
fi


SONGS_PN=ultrastar-songs

DESCRIPTION="SingStar GPL clone"
HOMEPAGE="http://sourceforge.net/projects/performous/"
SRC_URI="songs? (
		mirror://sourceforge/performous/${SONGS_PN}-restricted-3.zip
		mirror://sourceforge/performous/${SONGS_PN}-jc-1.zip
		mirror://sourceforge/performous/${SONGS_PN}-libre-3.zip
		mirror://sourceforge/performous/${SONGS_PN}-shearer-1.zip
	)"

PATCHES=(
	"${FILESDIR}"/${PN}-20130811-gentoo.patch
	"${FILESDIR}"/${PN}-20140927-libav.patch
	"${FILESDIR}"/${PN}-20140927-linguas.patch
)


LICENSE="GPL-2
	songs? (
		CCPL-Attribution-ShareAlike-NonCommercial-2.5
		CCPL-Attribution-NonCommercial-NoDerivs-2.5
	)"
SLOT="0"
IUSE="midi songs tools webcam"

RDEPEND="dev-cpp/glibmm
	dev-cpp/libxmlpp
	media-libs/portaudio
	dev-libs/boost[threads(+)]
	dev-libs/glib
	dev-libs/libxml2
	gnome-base/librsvg
	virtual/jpeg
	media-libs/libpng:0
	media-libs/libsdl2[joystick,video]
	virtual/ffmpeg
	virtual/opengl
	virtual/glu
	sys-libs/zlib
	virtual/libintl
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
	midi? ( media-libs/portmidi )
	tools? ( media-gfx/imagemagick )
	webcam? ( media-libs/opencv )"
DEPEND="${RDEPEND}
	media-libs/glew
	sys-apps/help2man
	sys-devel/gettext"

src_prepare() {
	base_src_prepare
	sed -i \
		-e "s:@GENTOO_BINDIR@:${GAMES_BINDIR}:" \
		game/CMakeLists.txt \
		|| die

	strip-linguas -u lang
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable tools TOOLS)
		$(usex midi "" "-DNO_PORTMIDI=ON")
		$(usex webcam "" "-DNO_WEBCAM=ON")
		-DCMAKE_VERBOSE_MAKEFILE=TRUE
		-DSHARE_INSTALL="${GAMES_DATADIR}"/${PN}
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	if use songs ; then
		insinto "${GAMES_DATADIR}"/${PN}
		doins -r "${WORKDIR}/songs"
	fi
	dodoc docs/{Authors,instruments}.txt
	prepgamesdirs
}
