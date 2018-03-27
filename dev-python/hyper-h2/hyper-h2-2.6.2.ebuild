# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="HTTP/2 State-Machine based protocol implementation"
HOMEPAGE="https://github.com/python-hyper/hyper-h2 https://pypi.python.org/pypi/h2"
SRC_URI="https://github.com/python-hyper/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/hyperframe-3.1[${PYTHON_USEDEP}]
	!=dev-python/hyperframe-4.0.0
	!>=dev-python/hyperframe-6
	>=dev-python/hpack-2.2[${PYTHON_USEDEP}]
	!>=dev-python/hpack-4
	$(python_gen_cond_dep '>=dev-python/enum34-1.0.4[${PYTHON_USEDEP}]' 'python2*' )
	$(python_gen_cond_dep '!>=dev-python/enum34-2[${PYTHON_USEDEP}]' 'python2*' )
"
