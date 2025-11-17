# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{6..13} )
DISTUTILS_USE_PEP517=setuptools

inherit autotools

DESCRIPTION="A utility for tagging single album FLAC files with embedded CUE sheets using data from the MusicBrainz service."
HOMEPAGE="http://software.gently.org.uk/flactag"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc +scripts"

DEPEND="app-text/unac
    media-libs/flac[cxx]
    media-libs/libdiscid
    media-libs/musicbrainz:5
    net-libs/neon
    sys-libs/slang
    virtual/jpeg
    doc? ( app-text/asciidoc )"

RDEPEND="${DEPEND}
    scripts? (
        app-cdr/cdrdao
        app-cdr/cuetools
        media-sound/cdparanoia
    )"


src_prepare() {
	if use scripts; then
		epatch ${FILESDIR}/${PN}-2-scripts.patch
	fi

	eapply_user
	eautoreconf
}

src_compile() {

	emake flactag discid
	if use doc ; then
		emake flactag.1
	fi
}

src_install() {
	dobin flactag discid
	if use doc ; then
		doman flactag.1
	fi
	if use scripts ; then
		dobin checkflac ripdataflac
		newbin ripflac.in ripflac
	fi
}
