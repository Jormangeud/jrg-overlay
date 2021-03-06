# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

TESTVER="abb579e00f2deeede91cb485e53512efab9c6474"
inherit distutils-r1

MY_PN="EditorConfig"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Clone of EditorConfig core written in Python"

HOMEPAGE="http://editorconfig.org/ https://github.com/editorconfig/editorconfig-core-py https://pypi.python.org/pypi/${MY_PN}"

SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz
	test? (
		https://github.com/${PN%-core-py}/${PN%-core-py}-core-test/archive/${TESTVER}.tar.gz -> ${PN%-core-py}-core-test-${TESTVER}.tar.gz
	)"

S="${WORKDIR}/${MY_P}"

LICENSE="PYTHON BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test cli"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? (
		>dev-util/cmake-3.0
	)
	!<app-vim/editorconfig-vim-0.3.3-r1"

src_prepare() {
	if use test; then
		mv "${WORKDIR}"/${PN%-core-py}-core-test-${TESTVER}/* "${S}"/tests || die
	fi

	use cli || eapply "${FILESDIR}"/${PN}-0.12.0-no-cli.patch

	default
	distutils-r1_src_prepare
}

python_install() {
	distutils-r1_python_install
	#use cli || rm -f "${D}/${EPREFIX}"/usr/bin
}

src_test() {
	__src_test_run_python_impl() {
		cmake -DPYTHON_EXECUTABLE="${PYTHON}" . || die "tests failed to build with ${EPYTHON}"
		ctest . || die "tests failed with ${EPYTHON}"
	}
	python_foreach_impl __src_test_run_python_impl
	unset __src_test_run_python_impl
}
