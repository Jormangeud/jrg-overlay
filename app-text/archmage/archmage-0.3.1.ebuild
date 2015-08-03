# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"


inherit distutils

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dottedmag/archmage.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dottedmag/archmage/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


DESCRIPTION="Extensible reader/decompiler of files in CHM format (Microsoft HTML help, also known as Compiled HTML)."
HOMEPAGE="http://archmage.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"

IUSE=""

DEPEND="dev-libs/chmlib
	dev-python/pychm
	dev-python/beautifulsoup
	"

src_install() {
	distutils_src_install
	dodoc INSTALL

}
