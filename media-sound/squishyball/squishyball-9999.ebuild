# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools versionator vcs-snapshot

if [[ ${PV} = *9999* ]]; then
	inherit subversion
	ESVN_REPO_URI="svn+https://svn.xiph.org/trunk/${PN}/"
	KEYWORDS=""
else
	MY_PV=$(replace_version_separator 2 '~svn')
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
	eapply_user
	eautoreconf
}
