# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1


if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aajanki/yle-dl.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/aajanki/yle-dl/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Download media files from Yle Areena"
HOMEPAGE="http://aajanki.github.io/yle-dl/"

LICENSE="GPL-3"
SLOT="0"

IUSE="test +youtube-dl"

# Requires an active internet connection during tests
RESTRICT="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-runner[${PYTHON_USEDEP}] )
"

RDEPEND="${DEPEND}
	>=dev-python/attrs-18.1.0[${PYTHON_USEDEP}]
	>=dev-python/configargparse-0.13.0[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	net-misc/wget
	virtual/ffmpeg[encode]
"

DOCS=( COPYING ChangeLog README.fi README.md yledl.conf.sample )

src_prepare() {
	default
}

python_test() {
	# For tests to run succesfully, you need to disable network stricting
	# feature first.
	#  FEATURES="-network-sandbox test" emerge -a yle-dl
	esetup.py test
}

python_install_all() {

	einstalldocs
	insinto /usr/share/${PN}/scripts
	doins scripts/*

	distutils-r1_python_install_all
}

pkg_postinst() {
	elog
	elog "FFMPEG will need support for SSL to work, so make sure that the"
	elog "media-video/ffmpeg or media-video/libav is compiled with one of"
	elog "the ssl use flags: openssl, libressl, gnutls."
	elog
	elog "Sample configuration file has been installed in "
	elog " /usr/share/doc/yle-dl-${PV}/yledl.conf.sample.bz2"
}
