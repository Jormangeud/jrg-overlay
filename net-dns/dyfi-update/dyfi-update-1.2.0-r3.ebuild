# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_P="${PN}-pl-${PV}"

DESCRIPTION="dy.fi dynamic DNS updater"
HOMEPAGE="http://www.dy.fi/page/clients"
SRC_URI="http://www.dy.fi/files/${MY_P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"

IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="dev-lang/perl"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch ${FILESDIR}/${PF}.gentoo.patch.bz2
}

pkg_setup() {
	enewgroup dyfi
}

src_install() {
	make DESTDIR=${D} install
	dodoc README
}

pkg_postinst() {

        if [ ! -e /var/log/dyfi-update.log ];
        then
                einfo "touching /var/log/dyfi-update.log and making it awailable only for root and dyfi..."
                touch /var/log/dyfi-update.log
                chown root:dyfi /var/log/dyfi-update.log
                fperms 660 /var/log/dyfi-update.log
        fi

        einfo "Configuration file is located at"
        einfo "/etc/dyfi-update.conf"
	einfo ""
}

