# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_6 )

inherit distutils-r1 versionator


if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="An interactive, SSL-capable, man-in-the-middle HTTP proxy"
HOMEPAGE="http://mitmproxy.org/"

LICENSE="MIT"
SLOT="0"
IUSE="doc examples test"

RDEPEND="
	>=dev-python/blinker-1.4[${PYTHON_USEDEP}]
	>=dev-python/brotlipy-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/certifi-2015.11.20.1[${PYTHON_USEDEP}]
	>=dev-python/click-6.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.1.4[${PYTHON_USEDEP}]
	>=dev-python/hyper-h2-3.0.1[${PYTHON_USEDEP}]
	>=dev-python/hyperframe-5.1[${PYTHON_USEDEP}]
	>=dev-python/kaitaistruct-0.7[${PYTHON_USEDEP}]
	>=dev-python/ldap3-2.5[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.6.5[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.5[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.1.3[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/ruamel-yaml-0.13.2[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-1.5.4[${PYTHON_USEDEP}]
	>=dev-python/urwid-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/wsproto-0.11.0[${PYTHON_USEDEP}]
	>=www-servers/tornado-4.3[${PYTHON_USEDEP}]
	examples? (
		>=dev-python/beautifulsoup-4.4.1[${PYTHON_USEDEP}]
	)
"
DEPEND=">=dev-python/setuptools-11.3[${PYTHON_USEDEP}]
	${RDEPEND}
"

python_prepare_all() {

	# remove limits for package versions in setup and define them in RDEPEND
	sed -i -e "s/,[ ]\?[<=>!]\+[0-9\.]\+//" setup.py || die

	distutils-r1_python_prepare_all
}


python_install_all() {
	local DOCS=( CHANGELOG )
	use doc && local HTML_DOCS=( doc/. )
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
