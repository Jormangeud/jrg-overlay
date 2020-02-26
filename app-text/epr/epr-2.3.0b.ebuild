# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/wustho/epr.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/wustho/epr/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi


DESCRIPTION="Terminal/CLI Epub reader written in Python"
HOMEPAGE="https://github.com/wustho/epr"

LICENSE="MIT"
SLOT="0"
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="
	${PYTHON_DEPS}
	sys-libs/ncurses
"
DEPEND="
	${RDEPEND}
"
