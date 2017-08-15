# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="HTTP/2 State-Machine based protocol implementation"
HOMEPAGE="https://github.com/python-hyper/hyper-h2 https://pypi.python.org/pypi/h2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-python/hyperframe-3.1[${PYTHON_USEDEP}]
	!=dev-python/hyperframe-4.0.0
	!>=dev-python/hyperframe-6
	>=dev-python/hpack-2.2[${PYTHON_USEDEP}]
	!>=dev-python/hpack-4
	$(python_gen_cond_dep '>=dev-python/enum34-1.0.4[${PYTHON_USEDEP}]' 'python2*' )
	$(python_gen_cond_dep '!>=dev-python/enum34-2[${PYTHON_USEDEP}]' 'python2*' )
"
