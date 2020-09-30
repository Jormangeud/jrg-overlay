# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ppannuto/python-titlecase.git"
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


DESCRIPTION="Python library to capitalize strings as specified by the New York Times Manual of Style"
HOMEPAGE="https://pypi.python.org/pypi/titlecase
    https://github.com/ppannuto/python-titlecase"

LICENSE="MIT"
SLOT="0"

IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	# Disable test
	sed -i -e "/setup_requires=\['nose>=1.0'\],/d" setup.py || die

	distutils-r1_python_prepare_all
}
