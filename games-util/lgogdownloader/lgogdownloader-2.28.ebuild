# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id:

EAPI=6

inherit eutils cmake-utils

DESCRIPTION="Linux compatible gog.com downloader"
HOMEPAGE="https://sites.google.com/site/gogdownloader/"
SRC_URI="https://sites.google.com/site/gogdownloader/${P}.tar.gz"

LICENSE="WTFPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/jsoncpp
	net-libs/liboauth
	net-misc/curl
	dev-libs/boost
	dev-libs/tinyxml
	app-crypt/librhash
	net-libs/htmlcxx"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3"

