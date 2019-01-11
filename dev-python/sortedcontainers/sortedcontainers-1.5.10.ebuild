# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="An Apache2 licensed sorted collections library, written in pure-Python"
HOMEPAGE="http://www.grantjenks.com/docs/sortedcontainers/ https://pypi.python.org/pypi/sortedcontainers https://github.com/grantjenks/python-sortedcontainers"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
