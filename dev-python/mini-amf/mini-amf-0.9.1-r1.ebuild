# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zackw/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/zackw/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


DESCRIPTION="AMF serialization and deserialization support for Python"
HOMEPAGE="https://pypi.org/project/Mini-AMF/
	https://github.com/zackw/mini-amf"

LICENSE="MIT"
SLOT="0"

IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
	dev-python/defusedxml
"
