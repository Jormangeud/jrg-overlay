# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Module for decoding audio files using whichever backend is available"
HOMEPAGE="https://pypi.python.org/pypi/audioread"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ffmpeg gstreamer -mad"


DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

DEPEND=""
RDEPEND="
	ffmpeg? ( virtual/ffmpeg )
	gstreamer? (
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		media-libs/gstreamer:1.0[introspection]
	)
	mad? ( dev-python/pymad[${PYTHON_USEDEP}] )
"
