# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils versionator

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bitlbee/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/bitlbee/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="The Facebook protocol plugin for bitlbee. This plugin uses the Facebook Mobile API."
HOMEPAGE="https://github.com/bitlbee/${PN}"
LICENSE="GPL-2"
SLOT="0"
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
