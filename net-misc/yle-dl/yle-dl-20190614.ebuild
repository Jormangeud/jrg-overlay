# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{5..7} )

inherit distutils-r1


if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aajanki/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/aajanki/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~ppc ~x86"
fi

DESCRIPTION="Download media files from Yle Areena"
HOMEPAGE="http://aajanki.github.io/yle-dl/"


LICENSE="GPL-3"
SLOT="0"

IUSE="+php +pycryptodome test +youtube-dl"

REQUIRED_USE="
	|| ( php youtube-dl )
"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-runner[${PYTHON_USEDEP}] )
"

RDEPEND="${DEPEND}
	>=dev-python/attrs-18.1.0[${PYTHON_USEDEP}]
	<dev-python/attrs-19.2.0[${PYTHON_USEDEP}]
	=dev-python/configargparse-0.13.0[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/mini-amf[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	php? (
		dev-lang/php[bcmath,cli,curl,simplexml,ssl]
		media-video/rtmpdump
	)
	pycryptodome? ( dev-python/pycryptodome[${PYTHON_USEDEP}] )
	!pycryptodome? ( dev-python/pycrypto[${PYTHON_USEDEP}] )
	youtube-dl? ( net-misc/youtube-dl[${PYTHON_USEDEP}] )
	virtual/ffmpeg[encode]
	net-misc/wget
"

DOCS=( COPYING ChangeLog README.fi README.md yledl.conf.sample )

src_prepare() {
	if use pycryptodome ; then
		sed -i -e "s|pycryptodomex|pycryptodome|g" setup.py || die 'sed failed'
	else
		sed -i -e "s|pycryptodomex|pycrypto|g" setup.py || die 'sed failed'
	fi
	default
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
}
