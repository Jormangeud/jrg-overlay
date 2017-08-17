# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} pypy{,3} )

inherit distutils-r1

MY_TAG="f29921d2048e"
S="${WORKDIR}/${PN}-${MY_TAG}"

DESCRIPTION="YAML parser/emitter that supports roundtrip comment preservation"
HOMEPAGE="https://pypi.python.org/pypi/ruamel.yaml https://bitbucket.org/ruamel/yaml"
SRC_URI="https://bitbucket.org/ruamel/yaml/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libyaml test"
REQUIRED_USE="${PYTHON_REQUIRED_USE} test? ( libyaml )"
# ^ tests can't be properly unbundled from the libyaml c-extension

RDEPEND="${PYTHON_DEPS}
	dev-python/ruamel-base[${PYTHON_USEDEP}]
	libyaml? ( dev-libs/libyaml )
	$(python_gen_cond_dep 'dev-python/ruamel-ordereddict[${PYTHON_USEDEP}]' python2_7)
	$(python_gen_cond_dep 'dev-python/typing[${PYTHON_USEDEP}]' python2_7)
"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	libyaml? ( $(python_gen_cond_dep 'dev-python/cython[${PYTHON_USEDEP}]' python2_7 'python3*') )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_configure_all() {
	if ! use libyaml ; then
		sed -i -e 's|\(ext_modules\)|no_\1|' __init__.py || die
	fi
}

python_install() {
	distutils-r1_python_install --single-version-externally-managed
	find "${ED}" -name '*.pth' -delete || die
}

python_test() {
	py.test -v _test/test_*.py || die
}
