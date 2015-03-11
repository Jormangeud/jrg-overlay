# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#

EAPI=5
#PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_COMPAT=( python{2_6,2_7} )

SNAPSHOT="yes"

#PYTHON
inherit git-2 distutils eutils

DESCRIPTION="Kodos is a Python GUI utility for creating, testing and debugging regular expressions."
HOMEPAGE="http://kodos.sourceforge.net/"

#EGIT_REPO_URI="http://github.com/luksan/kodos.git"
EGIT_REPO_URI="http://github.com/teythoon/kodos.git"
EGIT_PROJECT="kodos"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-python/PyQt4"

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	git-2_src_prepare
}

src_install() {
	distutils_src_install
}
