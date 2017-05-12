# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

MY_P=${P/_alpha/dev}

DESCRIPTION="Python and OpenOffice connectivity, and conversion tools."
HOMEPAGE="http://pypi.python.org/pypi/ootools"
SRC_URI="http://pypi.python.org/packages/source/o/ootools/${MY_P}.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"
