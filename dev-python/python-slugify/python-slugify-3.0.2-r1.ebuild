# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )
inherit distutils-r1

DESCRIPTION="A Python slugify application that handles unicode."
HOMEPAGE="https://github.com/un33k/python-slugify"
SRC_URI="https://github.com/un33k/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/unidecode-1.0.23[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
