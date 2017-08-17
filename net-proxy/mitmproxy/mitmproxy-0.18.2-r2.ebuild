# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_5 )

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
IUSE="doc examples"

RDEPEND="
	!www-servers/pathod
	!dev-python/netlib
	>=dev-python/backports-ssl-match-hostname-3.5.0.1[${PYTHON_USEDEP}]
	>=dev-python/blinker-1.4[${PYTHON_USEDEP}]
	>=dev-python/brotlipy-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/certifi-2015.11.20.1[${PYTHON_USEDEP}]
	>=dev-python/click-6.2[${PYTHON_USEDEP}]
	>=dev-python/configargparse-0.10[${PYTHON_USEDEP}]
	>=dev-python/cryptography-1.3[${PYTHON_USEDEP}]
	>=dev-python/cssutils-1.0.1[${PYTHON_USEDEP}]
        >=dev-python/flask-0.10.1[${PYTHON_USEDEP}]
        >=dev-python/h2-2.4.1[${PYTHON_USEDEP}]
        >=dev-python/html2text-2016.1.8[${PYTHON_USEDEP}]
        >=dev-python/hyperframe-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/jsbeautifier-1.6.3[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.5.0[${PYTHON_USEDEP}]
        >=dev-python/passlib-1.6.5[${PYTHON_USEDEP}]
        >=dev-python/pillow-3.2[${PYTHON_USEDEP}]
        >=dev-python/pyasn1-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/construct-2.5.2[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.16[${PYTHON_USEDEP}]
        >=dev-python/pyparsing-2.1.3[${PYTHON_USEDEP}]
        >=dev-python/pyperclip-1.5.22[${PYTHON_USEDEP}]
        >=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
        >=dev-python/six-1.10[${PYTHON_USEDEP}]
        >=dev-python/urwid-1.3.1[${PYTHON_USEDEP}]
        >=dev-python/watchdog-0.8.3[${PYTHON_USEDEP}]
        >=www-servers/tornado-4.3[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/enum34-1.0.4[${PYTHON_USEDEP}]' 'python2*')
	$(python_gen_cond_dep '>=dev-python/ipaddress-1.0.15[${PYTHON_USEDEP}]' 'python2*')
	$(python_gen_cond_dep '=dev-python/typing-3.5.2.2[${PYTHON_USEDEP}]' 'python2*')
"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

python_prepare_all() {

	# remove limits for package versions in setup and define them in RDEPEND
	sed -i -e "s/, [<=>]\+[0-9\.]\+//" setup.py || die

	distutils-r1_python_prepare_all

}

python_install_all() {
	local DOCS=( CHANGELOG CONTRIBUTORS )
	use doc && local HTML_DOCS=( doc/. )
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
