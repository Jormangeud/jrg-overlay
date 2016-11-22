# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4,3_5} )

MY_PN="python-$PN"

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ppannuto/${MY_PN}.git"
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

	KEYWORDS="~amd64 ~x86"
fi


DESCRIPTION="Python library to capitalize strings as specified by the New York Times Manual of Style"
HOMEPAGE="https://pypi.python.org/pypi/titlecase
    https://github.com/ppannuto/python-titlecase"

LICENSE="MIT"
SLOT="0"

IUSE=""

DEPEND=""

python_prepare_all() {
	# Disable test
	sed -i -e "/setup_requires=\['nose>=1.0'\],/d" setup.py || die

	distutils-r1_python_prepare_all
}
