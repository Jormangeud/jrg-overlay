# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{6..11} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dottedmag/archmage.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dottedmag/archmage/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


DESCRIPTION="Extensible reader/decompiler of files in CHM format (Microsoft HTML help, also known as Compiled HTML)."
HOMEPAGE="http://archmage.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"

IUSE=""

DEPEND="dev-libs/chmlib
	dev-python/pychm[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	"
src_prepare() {
	echo "${PV}" > RELEASE-VERSION
	default
}

src_install() {
	distutils-r1_src_install
}
