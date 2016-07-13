# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="SlimIt is a JavaScript minifier written in Python and provides a library that includes a JavaScript parser, lexer, pretty printer and a tree visitor."
HOMEPAGE="https://github.com/rspivak/${PN} https://pypi.python.org/pypi/${PN}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

PATCHES=( "${FILESDIR}/${P}-ply-3.6.patch" )

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
