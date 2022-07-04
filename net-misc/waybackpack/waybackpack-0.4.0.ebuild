# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{6..11} )

inherit distutils-r1

DESCRIPTION="Waybackpack is a command-line tool that lets you download the entire Wayback Machine archive for a given URL."
HOMEPAGE="https://github.com/jsvine/waybackpack"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/requests[${PYTHON_USEDEP}]
"
