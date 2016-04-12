# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 versionator

DESCRIPTION="An interactive, SSL-capable, man-in-the-middle HTTP proxy"
HOMEPAGE="http://mitmproxy.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="
	=dev-python/netlib-$(get_version_component_range 1-2)*[${PYTHON_USEDEP}]
        =dev-python/h2-2.1*[${PYTHON_USEDEP}]
        =www-servers/tornado-4.3*[${PYTHON_USEDEP}]
	=dev-python/configargparse-0.10*[${PYTHON_USEDEP}]
        =dev-python/pyperclip-1.5*[${PYTHON_USEDEP}]
	=dev-python/blinker-1.4*[${PYTHON_USEDEP}]
        =dev-python/pyparsing-2.1*[${PYTHON_USEDEP}]
        =dev-python/html2text-2016.1.8[${PYTHON_USEDEP}]
	=dev-python/pyconstruct-2.5*[${PYTHON_USEDEP}]
        =dev-python/six-1.10*[${PYTHON_USEDEP}]
        =dev-python/pillow-3.1*[${PYTHON_USEDEP}]
        =dev-python/watchdog-0.8*[${PYTHON_USEDEP}]
	=dev-python/click-6*[${PYTHON_USEDEP}]
        =dev-python/urwid-1.3*[${PYTHON_USEDEP}]
	=dev-python/lxml-3.5*[${PYTHON_USEDEP}]
	>=dev-python/enum34-1.0.4[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

python_prepare_all() {
	distutils-r1_python_prepare_all

	# don't run example scripts tests
	rm test/test_examples.py || die

}

python_install_all() {
	local DOCS=( CHANGELOG CONTRIBUTORS )
	use doc && local HTML_DOCS=( doc/. )
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
