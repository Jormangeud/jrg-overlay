# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI="4"
if [ "${PV#9999}" != "${PV}" ] ; then
	SCM=subversion
	ESVN_REPO_URI="svn://svn.gna.org/svn/vbrfix/trunk/vbrfix"
fi

inherit eutils qt4-r2 ${SCM}

DESCRIPTION="VBRFix fixes MP3s and re-constructs VBR headers. It can also be used to remove unrecognised data from the mp3 and spot other problems."
HOMEPAGE="http://home.gna.org/vbrfix/"
if [ "${PV#9999}" != "${PV}" ] ; then
	SRC_URI=""
elif [ "${PV%_p*}" != "${PV}" ] ; then # Snapshot
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
else # Release
	SRC_URI="http://download.gna.org/vbrfix/${P}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X +cli"

RDEPEND="cli? ( dev-qt/qtcore:4 )
	X? ( dev-qt/qtgui:4 media-libs/libpng )"
DEPEND="${RDEPEND}"
MAKEOPTS="${MAKEOPTS} -j1" # has to set as fails otherwise

pkg_setup() {
	if ! ( use X || use cli) ; then
		eerror "At least one of the X or cli flags has to be selected."
		die
	fi
}
src_configure() {
	if ! use X ; then
		sed -i 's|QtFixer|#QtFixer|' vbrfix.pro || die 'sed failed'
	fi
	if ! use cli ; then
		sed -i '/ConsoleFixer/d' vbrfix.pro || die 'sed failed'
	fi

	eqmake4 vbrfix.pro || die "eqmake4 failed."
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
