# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Linguistic morphological programming language and toolset"
HOMEPAGE="http://home.arcor.de/bjoern-beutel/malaga/"
SRC_URI="http://home.arcor.de/bjoern-beutel/malaga/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk doc readline"

DEPEND=">=dev-libs/glib-2.0
	gtk? ( >=x11-libs/gtk+-2.8 )
	doc? ( >=sys-apps/texinfo-4.0 )
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_with readline ) $(use_enable gtk malshow )
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc CHANGES.txt INSTALL.txt README.txt
}
