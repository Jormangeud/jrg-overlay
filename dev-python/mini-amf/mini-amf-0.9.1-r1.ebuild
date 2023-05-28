# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5..11} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zackw/mini-amf.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/zackw/mini-amf/archive/v${PV}.tar.gz -> ${P}.tar.gz"
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
