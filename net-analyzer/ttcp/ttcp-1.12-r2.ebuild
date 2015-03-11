# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ttcp/ttcp-1.12-r1.ebuild,v 1.2 2010/08/26 16:03:17 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Tool to test TCP and UDP throughput"
HOMEPAGE="
	http://ftp.arl.mil/~mike/ttcp.html
	http://www.netcore.fi/pekkas/linux/ipv6/
"
SRC_URI="
	mirror://gentoo/${P}.tar.bz2
	http://www.netcore.fi/pekkas/linux/ipv6/ttcp.c -> ${PN}-ipv6.c
"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""

src_unpack() {
	default
	cp "${DISTDIR}"/${PN}-ipv6.c "${S}/${PN}.c"
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o ${PN} ${PN}.c || die "compile failed"
}

src_install() {
	dobin ${PN} || die
	newman sgi-${PN}.1 ${PN}.1 || die
}
