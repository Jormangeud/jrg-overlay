# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit versionator distutils-r1

DESCRIPTION="Helper scripts for Calibre ebook management"
HOMEPAGE="http://pypi.python.org/pypi/mekk.calibre/"
SRC_URI="https://pypi.python.org/packages/source/m/mekk.calibre/mekk.calibre-${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="chm djvu doc2rtf mso pdf"

DEPEND=">=dev-lang/python-2.6
		dev-python/lxml"
RDEPEND=">=app-text/calibre-0.7
		chm? ( app-text/archmage )
		djvu? ( app-text/djvu )
		doc2rtf? ( dev-python/ootools )
		mso? ( app-text/catdoc )
		pdf? ( app-text/poppler[utils] )
"
S="${WORKDIR}/mekk.calibre-${PV}"

src_install() {
	distutils-r1_src_install
	dodoc README.txt
}
