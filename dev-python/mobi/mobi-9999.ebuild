# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{7..11} )

inherit distutils-r1

DESCRIPTION="Library for unpacking unencrypted mobi files"
HOMEPAGE="https://github.com/iscc/mobi"
if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/iscc/mobi.git"
	KEYWORDS=""
else
	# SRC_URI="https://github.com/iscc/mobi/archive/refs/tags/v0.3.3.tar.gz -> ${P}.gh.tar.gz"
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi


LICENSE="GPL-3"
SLOT="0"
