# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-single-r1


TAG="38f6e055eb4516f2fc072868de42c7f1c0321f0a"

KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kimvais/kiehinen.git"
	KEYWORDS=""
else
	#SRC_URI="https://github.com/kimvais/kiehinen/archive/${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/kimvais/kiehinen/archive/${TAG}.zip -> ${P}.zip"
fi


DESCRIPTION="A manager for Amazon Kindle with graphical UI"
HOMEPAGE="https://github.com/kimvais/kiehinen"

LICENSE="AS-IS"
SLOT="0"

IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/beautifulsoup
	dev-python/configparser
	dev-python/PyQt4
	dev-python/simplejson
	"
DEPEND=${RDEPEND}

src_prepare() {
	epatch "${FILESDIR}/${PN}-PyQt4.patch"
	epatch "${FILESDIR}/${PN}-libfix.patch"
}

src_compile() {
	return
}

src_install() {
	python_doscript kiehinen
	python_moduleinto kiehinen
	python_domodule *.py
	python_domodule icons
	python_fix_shebang "${ED}"usr/bin
	python_optimize
}
