# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} pypy )

MY_PN="EditorConfig"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="EditorConfig File Locator and Interpreter for Python"
HOMEPAGE="http://editorconfig.org/ https://github.com/editorconfig/editorconfig-core-py https://pypi.python.org/pypi/${MY_PN}"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="PSF-2 CNRI PYTHON"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"