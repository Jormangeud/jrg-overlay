# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${PN}-pl-${PV}"

DESCRIPTION="dy.fi dynamic DNS updater"
HOMEPAGE="http://www.dy.fi/page/clients"
SRC_URI="http://www.dy.fi/files/${MY_P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"

IUSE=""
SLOT="0"
LICENSE="GPL-2"

RDEPEND="acct-group/dyfi
	dev-lang/perl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	eapply ${FILESDIR}/${PF}.gentoo.patch
	eapply_user
}

src_install() {
	make DESTDIR=${D} install
	dodoc README
}

pkg_postinst() {

	if [ ! -e /var/log/dyfi-update.log ]; then
		touch /var/log/dyfi-update.log
		chown root:dyfi /var/log/dyfi-update.log /etc/dyfi-update.conf
		fperms 660 /var/log/dyfi-update.log /etc/dyfi-update.conf
	fi

	einfo "Configuration file is located at"
	einfo "/etc/dyfi-update.conf"
	einfo ""
}
