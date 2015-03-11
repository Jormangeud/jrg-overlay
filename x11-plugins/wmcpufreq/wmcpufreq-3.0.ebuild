# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit eutils toolchain-funcs

DESCRIPTION="Dockapp showing CPU frequency and governor"
HOMEPAGE="http://dockapps.windowmaker.org/file.php/id/309"
SRC_URI="http://dockapps.windowmaker.org/download.php/id/862/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	sys-power/cpufrequtils
"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" || die "emake failed."
}

src_install() {
	dobin ${PN}/${PN}
	dodoc README
}
