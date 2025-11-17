# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1 pypi

DESCRIPTION="python library to extract, transform and metadata for ISBNs"
HOMEPAGE="
    https://pypi.python.org/pypi/isbntools
    https://github.com/xlcnd/isbntools
"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
    dev-python/isbnlib[${PYTHON_USEDEP}]
"
