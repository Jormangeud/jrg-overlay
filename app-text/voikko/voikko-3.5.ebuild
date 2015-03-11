# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Free Finnish spellchecking and hyphenation library"
HOMEPAGE="http://voikko.sf.net"
SRC_URI="mirror://sourceforge/voikko/lib${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sci-misc/malaga
	>=sci-misc/suomi-malaga-1.4
	virtual/libiconv"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	=dev-lang/python-2*"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch $FILESDIR/python2.diff
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README
	rm "${D}"/usr/$(get_libdir)/*.la
	rm "${D}"/usr/$(get_libdir)/*.a
}
