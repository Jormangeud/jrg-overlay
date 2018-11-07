# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils multilib toolchain-funcs

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tuffy/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/tuffy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


DESCRIPTION="libDVD-Audio is a small C library for extracting audio from DVD-Audio discs, analogous to libcdio"
HOMEPAGE="https://sourceforge.net/projects/libdvd-audio/
	https://github.com/tuffy/libdvd-audio
"

LICENSE="GPL-2
	LGPL-3"
SLOT="0"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {

	epatch "${FILESDIR}/${P}-Makefile.patch" || die "patch failed"

	sed -i -e "s|FLAGS = -Wall -O2 -g -fPIC|FLAGS = -Wall -g -fPIC ${CFLAGS} ${LDFLAGS}|" \
			-e "s|LIB_DIR = /usr/local/lib|LIB_DIR = ${EPREFIX}/usr/$(get_libdir)|" \
			-e "s|INCLUDE_DIR = /usr/local/include|INCLUDE_DIR = ${EPREFIX}/usr/include|" \
			-e "s|BIN_DIR = /usr/local/bin|BIN_DIR = ${EPREFIX}/usr/bin|" \
			-e "s|PKG_CONFIG_DIR = /usr/lib/pkgconfig|PKG_CONFIG_DIR = /usr/$(get_libdir)/pkgconfig|" \
			-e "s| \$(LIB_DIR)| \$(DESTDIR)\$(LIB_DIR)|g" \
			-e "s| \$(INCLUDE_DIR)| \$(DESTDIR)\$(INCLUDE_DIR)|g" \
			-e "s| \$(BIN_DIR)| \$(DESTDIR)\$(BIN_DIR)|g" \
			-e "s| \$(PKG_CONFIG_DIR)| \$(DESTDIR)\$(PKG_CONFIG_DIR)|g" \
			Makefile || die "couldn't fix Makefile"

	eapply_user
}

src_compile() {
	emake CC=$(tc-getCC) AR=$(tc-getAR) DESTDIR=${D}
}
