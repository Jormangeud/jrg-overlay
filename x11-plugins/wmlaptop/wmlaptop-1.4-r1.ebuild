# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmlaptop/wmlaptop-1.4.ebuild,v 1.2 2012/02/15 09:49:42 voyageur Exp $

inherit eutils toolchain-funcs

IUSE=""

MY_P="${P}"
S="${WORKDIR}/${MY_P}/src"

DESCRIPTION="Dockapp for laptop users"
SRC_URI="http://dockapps.windowmaker.org/download.php/id/509/${P}.tar.gz"
HOMEPAGE="http://dockapps.windowmaker.org/file.php/id/227"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	>=sys-apps/sed-4.1.5-r1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-Makefile.patch
	epatch "${FILESDIR}"/${PN}-ACPI-detection.patch
	epatch "${FILESDIR}"/${PN}-ondemand.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" || die "emake failed."
}

src_install() {
	dodir /usr/bin
	einstall INSTALLDIR="${D}/usr/bin" || die "Installation failed"

	dodoc ../AUTHORS ../README ../README.IT ../THANKS

	insinto /usr/share/applications
	doins "${FILESDIR}/${PN}.desktop"
}
