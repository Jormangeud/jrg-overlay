# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils qmake-utils

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fidget77/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="http://download.gna.org/vbrfix/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="VBRFix fixes MP3s and re-constructs VBR headers. It can also be used to remove unrecognised data from the mp3 and spot other problems."
HOMEPAGE="http://home.gna.org/vbrfix/"

LICENSE="GPL-2"
SLOT="0"
IUSE="X +cli"

RDEPEND="cli? ( dev-qt/qtcore:5 )
	X? ( dev-qt/qtwidgets:5 media-libs/libpng )"
DEPEND="${RDEPEND}"
MAKEOPTS="${MAKEOPTS} -j1" # has to set as fails otherwise
CXXFLAGS="${CXXFLAGS} -std=c++11"

pkg_setup() {
	if ! ( use X || use cli) ; then
		eerror "At least one of the X or cli flags has to be selected."
		die
	fi
}
src_prepare() {
	eapply "${FILESDIR}/${P}-qt4toqt5.patch"
	default
}
src_configure() {
	if ! use X ; then
		sed -i 's|QtFixer|#QtFixer|' vbrfix.pro || die 'sed failed'
	fi
	if ! use cli ; then
		sed -i '/ConsoleFixer/d' vbrfix.pro || die 'sed failed'
	fi
	eqmake5 || die "eqmake failed."
}

src_install() {
	dodoc README || die "Installing docs failed."

	exeinto /usr/bin
	if use X ; then
		newexe "QtFixer/VbrfixGui" vbrfixgui || die "Installing gui binary failed."
	fi
	if use cli ; then
		newexe "ConsoleFixer/VbrfixConsole" vbrfix || die "Installing cli binary failed."
	fi

}
