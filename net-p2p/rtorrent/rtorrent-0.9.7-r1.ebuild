# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools linux-info systemd eutils versionator

DESCRIPTION="BitTorrent Client using libtorrent"
HOMEPAGE="https://rakshasa.github.io/rtorrent/"
SRC_URI="http://rtorrent.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris"
IUSE="daemon debug pyroscope selinux test xmlrpc"
REQUIRED_USE="pyroscope? ( xmlrpc )"

COMMON_DEPEND="~net-libs/libtorrent-0.13.${PV##*.}
	>=dev-libs/libsigc++-2.2.2:2
	>=net-misc/curl-7.61.0
	sys-libs/ncurses:0=
	xmlrpc? ( dev-libs/xmlrpc-c )"
RDEPEND="${COMMON_DEPEND}
	daemon? ( app-misc/screen )
	selinux? ( sec-policy/selinux-rtorrent )
"
DEPEND="${COMMON_DEPEND}
	dev-util/cppunit
	virtual/pkgconfig"

DOCS=( doc/rtorrent.rc )
PATCHES=(
	"${FILESDIR}/${PN}-0.9.7-tinfo.patch"
	"${FILESDIR}/${PN}-0.9.7-execinfo-configure.patch"
)

src_prepare() {
	default

	# https://github.com/rakshasa/rtorrent/issues/332
	cp "${FILESDIR}"/rtorrent.1 "${S}"/doc/ || die

	if use pyroscope; then
        einfo "using pyro"
		cp "${FILESDIR}"/ps/{command_pyroscope.cc,ui_pyroscope.cc,ui_pyroscope.h} "${S}"/src

		EPATCH_SOURCE="${FILESDIR}/ps/all" EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" eapply || die
		EPATCH_SOURCE="${FILESDIR}/ps/${PV}" EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" eapply || die

		RT_HEX_VERSION=0x0$(replace_all_version_separators '0')
		sed -i -e "s:\\(AC_DEFINE(HAVE_CONFIG_H.*\\):\1\nAC_DEFINE(RT_HEX_VERSION, $RT_HEX_VERSION, for CPP if checks):" configure.ac

	fi

	eautoreconf
}

src_configure() {
	default

	# configure needs bash or script bombs out on some null shift, bug #291229
	CONFIG_SHELL=${BASH} econf \
		$(use_enable debug) \
		$(use_with xmlrpc xmlrpc-c)
}

src_install() {
	default
	doman doc/rtorrent.1

	if use daemon; then
		newinitd "${FILESDIR}/rtorrentd.init" rtorrentd
		newconfd "${FILESDIR}/rtorrentd.conf" rtorrentd
		systemd_newunit "${FILESDIR}/rtorrentd_at.service" "rtorrentd@.service"
	fi
}
