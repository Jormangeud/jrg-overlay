# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="CLI program designed to display tag data and audio format information for Monkey's Audio files."
HOMEPAGE="https://www.legroom.net/software/apeinfo"
SRC_URI="https://www.legroom.net/files/software/apeinfo11_source.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DOCS=""

DEPEND="=media-sound/mac-3.99*"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	mkdir "${S}"
	mv "${WORKDIR}/${PN}.cpp" "${S}"
	cd "${S}"
	eapply ${FILESDIR}/${P}.patch
}

src_compile() {
	append-ldflags mac
	$(tc-getCXX) -lmac ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} -o ${PN} ${PN}.cpp || die
}

src_install() {
	dobin ${PN}
}
