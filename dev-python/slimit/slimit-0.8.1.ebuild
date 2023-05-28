# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..11}} )

inherit distutils-r1

DESCRIPTION="SlimIt is a JavaScript minifier written in Python and provides a library that includes a JavaScript parser, lexer, pretty printer and a tree visitor."
HOMEPAGE="https://github.com/rspivak/slimit https://pypi.python.org/pypi/slimit"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

PATCHES=(
	"${FILESDIR}/${P}-pull-48+60.patch"
	"${FILESDIR}/${P}-pull-71.patch"
	"${FILESDIR}/${P}-pull-79.patch"
	"${FILESDIR}/${P}-pull-83.patch"
	 )

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
