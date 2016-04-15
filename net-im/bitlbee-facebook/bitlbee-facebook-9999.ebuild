# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 eutils autotools

DESCRIPTION="The Facebook protocol plugin for bitlbee. This plugin uses the Facebook Mobile API."
HOMEPAGE="https://github.com/jgeboski/bitlbee-facebook"
SRC_URI=""
EGIT_REPO_URI="https://github.com/jgeboski/bitlbee-facebook.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/glib:2
>=net-im/bitlbee-3.4.1[plugins]
>=dev-libs/json-glib-1.0.4"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	default
	prune_libtool_files
}
