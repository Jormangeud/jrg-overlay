# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

MY_PN=Py3AMF
MY_P=${MY_PN}-${PV}

DESCRIPTION="Action Message Format (AMF) support for Python 3"
HOMEPAGE="https://github.com/StdCarrot/Py3AMF https://pypi.python.org/pypi/Py3AMF"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/defusedxml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${MY_P}

python_test() {
	esetup.py test
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "Py3AMF optionally integrates with several third-party libraries"
		elog "and web frameworks. See the README or the Optional Extras section at"
		elog "https://github.com/StdCarrot/Py3AMF/blob/master/doc/install.rst"
	fi
}
