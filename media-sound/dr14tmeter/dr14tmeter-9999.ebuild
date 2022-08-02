# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{6..11} )

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
RDEPEND="virtual/ffmpeg[encode]
	flac? ( media-libs/flac )
	mp3? ( media-sound/lame )
	ogg? ( media-sound/vorbis-tools )
	dev-python/numpy[${PYTHON_USEDEP}]"

src_prepare() {
	default

	sed -i '/cmdclass/d' setup.py
}


python_install_all() {
	distutils-r1_python_install_all

	doman man/dr14_tmeter.1
}

