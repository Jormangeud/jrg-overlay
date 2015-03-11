# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

DESCRIPTION="Audio broadcasting tool with Jack interface for Shoutcast, Icecast, Icecast2"
HOMEPAGE="http://www.oddsock.org/tools/edcast_jack/"
SRC_URI="http://www.oddsock.org/tools/edcast_jack/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE="aac flac lame vorbis"

DEPEND="
	media-sound/jack-audio-connection-kit
	aac? ( media-libs/faac )
	flac? ( media-libs/flac
		media-libs/libogg )
	lame? ( media-libs/libmad
		media-sound/lame )
	vorbis? ( media-libs/libvorbis
		media-libs/libogg )
	"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/${PV}_encode-flac-fix.diff
	einfo "Regenerating autotools files..."

	# fix undefined macros
	# http://www.gentoo.org/proj/en/qa/autofailure.xml
	AT_M4DIR="m4" eautoreconf || die "autoreconf failed"
	eautomake || die "automake failed"
}

src_compile() {

# automake automagic dependencies need fixing
# http://www.gentoo.org/proj/en/qa/automagic.xml
#
#	econf \
#		$(use_enable aac faac) \
#		$(use_with flac libFLAC) \
#		$(use_with lame) \
#		$(use_with vorbis) \
#		|| die
	econf || die
	emake || die "emake failed"

}

src_install() {

        dodoc AUTHORS COPYING COPYING README
	dodoc conf/*	
	einstall || die "Install failed."

}
