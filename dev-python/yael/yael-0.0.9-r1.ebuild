# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{6..14} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pettarin/yael.git"
	KEYWORDS=""
else
	#SRC_URI="https://github.com/${GIT_ACCOUNT}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://testpypi.python.org/packages/bc/45/92699fbae6f5a2d5cbd6e42e356a732016911e1c5bafcf6733c5b8ed5e8b/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


DESCRIPTION="yael (Yet Another EPUB Library) is a Python library for reading, manipulating, and writing EPUB 2/3 files."
HOMEPAGE="http://www.albertopettarin.it/yael/ https://github.com/pettarin/yael"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="-doc"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/simplejson-3.6.0[${PYTHON_USEDEP}]"
#	doc? ( dev-python/sphinx )
