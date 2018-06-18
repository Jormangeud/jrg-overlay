# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1 eutils

DESCRIPTION="Library for audio labelling (python bindings)"
HOMEPAGE="https://aubio.org/"
SRC_URI="https://aubio.org/pub/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0/5"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="
	~media-libs/aubio-${PV}
"
DEPEND="
	${RDEPEND}
	${PYTHON_DEPS}
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PYTHON_SRC_DIR="${S}"

src_configure() {
	cd "${PYTHON_SRC_DIR}" || die
	distutils-r1_src_configure
}

src_compile() {
	cd "${PYTHON_SRC_DIR}" || die
	distutils-r1_src_compile
}

src_test() {
	cd "${PYTHON_SRC_DIR}" || die
	distutils-r1_src_test
}

src_install() {
	cd "${PYTHON_SRC_DIR}" || die
	DOCS="" distutils-r1_src_install
	newdoc python/README.md README.python
}
