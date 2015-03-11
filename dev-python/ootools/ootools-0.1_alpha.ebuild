# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherrytemplate/cherrytemplate-1.0.0.ebuild,v 1.7 2010/07/03 23:01:50 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

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
