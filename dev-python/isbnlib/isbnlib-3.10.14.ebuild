# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1 pypi

DESCRIPTION="python library to validate, clean, transform and get metadata of ISBN strings (for devs)."
HOMEPAGE="
    https://pypi.python.org/pypi/isbnlib
    https://github.com/xlcnd/isbnlib
"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
    dev-python/wheel[${PYTHON_USEDEP}]
    dev-python/twine[${PYTHON_USEDEP}]
"
