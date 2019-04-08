# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} pypy{,3} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Python MPD client library"
HOMEPAGE="https://github.com/Mic92/python-mpd2 https://pypi.python.org/pypi/python-mpd"
SRC_URI="https://github.com/Mic92/${PN}2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
SLOT="0"
IUSE="test"

DEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( doc/changes.rst doc/topics/{advanced,commands,getting-started,logging}.rst README.rst )

python_test() {
	"${PYTHON}" test.py || die "Tests fail with ${EPYTHON}"
}
