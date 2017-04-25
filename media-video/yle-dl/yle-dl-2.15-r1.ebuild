# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="Download media files from Yle Areena"
HOMEPAGE="http://aajanki.github.io/yle-dl/"
SRC_URI="https://github.com/aajanki/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"

IUSE="+php +youtube-dl"

REQUIRED_USE="
	|| ( php youtube-dl )
"

DEPEND="
	dev-python/pycrypto[${PYTHON_USEDEP}]
	php? (
		dev-lang/php[bcmath,curl,crypt,simplexml]
		media-video/rtmpdump
	)
	youtube-dl? ( net-misc/youtube-dl[python_targets_python2_7] )
"

RDEPEND="${DEPEND}"

src_prepare() {
	python_fix_shebang .

	sed -i 's|/usr/local|/usr|g' Makefile
	sed -i 's|/usr/local/share/yle-dl/AdobeHDS.php|/usr/share/yle-dl/AdobeHDS.php|g' yle-dl

	default
}

