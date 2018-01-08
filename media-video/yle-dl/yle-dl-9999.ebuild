# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=(python{2_7,3_5,3_6})

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

IUSE="+php +youtube-dl"

REQUIRED_USE="
	|| ( php youtube-dl )
"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pyamf[${PYTHON_USEDEP}]
	dev-python/pycrypto[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	php? (
		dev-lang/php[bcmath,curl,crypt,simplexml]
		media-video/rtmpdump
	)
	youtube-dl? ( net-misc/youtube-dl[${PYTHON_USEDEP}] )
	virtual/ffmpeg[encode]
	net-misc/wget
"

DOCS=( COPYING ChangeLog README.fi README.md )

python_install_all() {

	einstalldocs
	insinto /usr/share/${PN}/scripts
	doins scripts/*

	distutils-r1_python_install_all
}
