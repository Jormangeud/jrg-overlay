# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python2_7 python3_{5..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="An unofficial client library for Google Music"
HOMEPAGE="https://github.com/simon-weber/gmusicapi"
SRC_URI="https://github.com/simon-weber/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=">=dev-python/appdirs-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/decorator-4.0.10[${PYTHON_USEDEP}]
	>=dev-python/future-0.15.2[${PYTHON_USEDEP}]
	>=dev-python/gpsoauth-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/MechanicalSoup-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/mock-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/oauth2client-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.20.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/validictory-1.0.2[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.5.3[${PYTHON_USEDEP}]
	>=media-libs/mutagen-1.34.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/proboscis-1.2.6.0[${PYTHON_USEDEP}] )"

python_test() {
	${PYTHON} ${PN}/test/run_tests.py --group=local || die
}
