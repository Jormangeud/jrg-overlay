# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..11} pypy )

inherit distutils-r1

DESCRIPTION="Wrap the Unrar DLL to enable unraring of files in python"
HOMEPAGE="https://pypi.python.org/pypi/unrardll https://github.com/kovidgoyal/unrardll"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~x86"
IUSE="test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
	app-arch/unrar"

python_test() {
	py.test || die
}

python_prepare_all() {

	# replace unrar dll reference
	sed 's/<unrar\/dll.hpp>/<libunrar5\/dll.hpp>/' \
		-i src/unrardll/wrapper.cpp

	distutils-r1_python_prepare_all
}
