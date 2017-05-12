# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 )
SNAPSHOT="yes"

inherit distutils-r1 eutils

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="http://github.com/luksan/kodos.git"
	#EGIT_REPO_URI="http://github.com/teythoon/kodos.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/luksan/kodos/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Kodos is a Python GUI utility for creating, testing and debugging regular expressions."
HOMEPAGE="http://kodos.sourceforge.net/"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-python/PyQt4"

src_prepare() {
	sed -i -e "s/subprocess.check_call(['make'])//" setup.py
	distutils-r1_src_prepare
}

src_compile() {
	emake
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
}
