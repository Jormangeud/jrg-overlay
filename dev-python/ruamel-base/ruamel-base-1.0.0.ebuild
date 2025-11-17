# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python2_7 python3_{5..14} )

inherit distutils-r1

MY_PN="ruamel.base"
MY_P="${MY_PN}-${PV}"
MODNAME="ruamel"

DESCRIPTION="common routines for ruamel packages"
HOMEPAGE="https://pypi.python.org/pypi/ruamel.base"
SRC_URI="mirror://pypi/r/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

python_install() {
	cat > "${S}"/${MODNAME}/__init__.py <<-EOF || die
		__import__('pkg_resources').declare_namespace(__name__)
	EOF
	python_foreach_impl python_domodule ${MODNAME}

	distutils-r1_python_install --single-version-externally-managed
	find "${ED}" -name '*.pth' -delete || die
}
