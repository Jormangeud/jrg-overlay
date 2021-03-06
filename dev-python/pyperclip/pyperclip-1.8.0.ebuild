# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI=7
PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1 virtualx

DESCRIPTION="Cross-platform clipboard module"
HOMEPAGE="https://github.com/asweigart/pyperclip https://pypi.python.org/pypi/pyperclip"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
    app-arch/unzip"
RDEPEND="test? (
	|| ( x11-misc/xsel
	    x11-misc/xclip
	    dev-python/PyQt5[${PYTHON_USEDEP}] )
	)"

RESTRICT="test"
# tests are not part of the pypi tarball and there are no tags on github

python_compile() {
	unset DISPLAY
    distutils-r1_python_compile
}

python_test() {
	virtx esetup.py test
}
