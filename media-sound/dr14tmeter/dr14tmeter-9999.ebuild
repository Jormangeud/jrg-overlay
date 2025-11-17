# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{6..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/simon-r/dr14_t.meter.git"
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Compute the DR14 value of the given audio files"
HOMEPAGE="http://dr14tmeter.sourceforge.net/"
LICENSE="GPL-3+"
SLOT="0"
IUSE="flac mp3 ogg"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="media-video/ffmpeg
	flac? ( media-libs/flac )
	mp3? ( media-sound/lame )
	ogg? ( media-sound/vorbis-tools )
	dev-python/numpy[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}/${PN}-01-fix-WavPack-and-Monkeys-Audio.patch"
	"${FILESDIR}/${PN}-02-add-support-for-album-DR.patch"
	"${FILESDIR}/${PN}-03-move-duplicated-functionality.patch"
	"${FILESDIR}/${PN}-04-simplify-filetype-selection.patch"
	"${FILESDIR}/${PN}-05-add-DSF-and-Wavpack-support.patch"
	"${FILESDIR}/${PN}-06-add-Musepack-support.patch"
	"${FILESDIR}/${PN}-python313.patch"
)

src_prepare() {
	default

	sed -i '/cmdclass/d' setup.py
}


python_install_all() {
	distutils-r1_python_install_all

	doman man/dr14_tmeter.1
}

