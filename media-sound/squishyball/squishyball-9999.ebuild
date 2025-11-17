# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools vcs-snapshot

if [[ ${PV} = *9999* ]]; then
	KEYWORDS=""
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.xiph.org/xiph/squishyball.git"
else
	MY_PV=$(ver_rs 2 '~svn')
	SRC_URI="http://http.debian.net/debian/pool/main/s/${PN}/${PN}_${MY_PV}.orig.tar.xz -> ${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Audio sample comparison testing tool (ABX)."
HOMEPAGE="http://svn.xiph.org/trunk/squishyball/"
LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND="media-libs/libao
	media-libs/flac
	media-libs/libvorbis
	media-libs/opusfile
	sys-libs/ncurses
"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply "${FILESDIR}/${PN}-debian-patches.diff"
	eapply "${FILESDIR}/0001-mincurses.c-use-ncurses-API-to-enter-raw-mode-ncurse.patch"
	eapply "${FILESDIR}/configure.ac.diff"
	eapply_user
	eautoreconf
}
