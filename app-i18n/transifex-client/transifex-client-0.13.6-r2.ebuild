# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="A command line interface for Transifex"
HOMEPAGE="https://pypi.org/project/transifex-client/ http://www.transifex.net/"
SRC_URI="mirror://pypi/t/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/mock[${PYTHON_USEDEP}] )"
RDEPEND="
	>=dev-python/requests-2.19.1[${PYTHON_USEDEP}]
	<dev-python/requests-3.0.0[${PYTHON_USEDEP}]
	>dev-python/six-1.11.0[${PYTHON_USEDEP}]
	dev-python/python-slugify[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"

python_test() {
	esetup.py test
}

python_prepare_all() {

	# remove limits for package versions in setup and define them in RDEPEND
	sed -i -e 's/\(,\?[ ]\?[<=>!]\+[0-9\.]\+\)\+//' requirements.txt || die

	distutils-r1_python_prepare_all
}
