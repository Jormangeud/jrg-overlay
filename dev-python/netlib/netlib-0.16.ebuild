# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION=""
HOMEPAGE="http://mitmproxy.org/"
SRC_URI="https://github.com/mitmproxy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	=dev-python/backports-ssl-match-hostname-3.5[${PYTHON_USEDEP}]
	>=dev-python/certifi-2015.11.20.1[${PYTHON_USEDEP}]
	=dev-python/cryptography-1.2*[${PYTHON_USEDEP}]
        =dev-python/hpack-2*[${PYTHON_USEDEP}]
        =dev-python/hyperframe-3*[${PYTHON_USEDEP}]
	=dev-python/ipaddress-1.0*[${PYTHON_USEDEP}]
        =dev-python/passlib-1.6*[${PYTHON_USEDEP}]
        =dev-python/pyasn1-0.1.9*[${PYTHON_USEDEP}]
	=dev-python/pyopenssl-0.15*[${PYTHON_USEDEP}]
        =dev-python/six-1.10*[${PYTHON_USEDEP}]
"

