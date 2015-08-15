# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qscintilla/qscintilla-2.9.ebuild,v 1.1 2015/04/30 13:36:24 pesa Exp $

EAPI=5

inherit flag-o-matic qmake-utils

MY_P=QScintilla-gpl-${PV}

DESCRIPTION="A Qt port of Neil Hodgson's Scintilla C++ editor class"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/qscintilla/intro"
SRC_URI="mirror://sourceforge/pyqt/${MY_P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0/12"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="designer doc qt5"

DEPEND="
	>=dev-qt/qtcore-4.8.5:4
	>=dev-qt/qtgui-4.8.5:4
	designer? ( >=dev-qt/designer-4.8.5:4 )
	qt5? ( dev-qt/qtcore:5 dev-qt/qtgui:5 dev-qt/qtwidgets:5 dev-qt/qtprintsupport:5 )
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	default

	# Sub-slot sanity check
	local subslot=${SLOT#*/}
	local version=$(sed -nre 's:.*VERSION\s*=\s*([0-9\.]+):\1:p' "${S}"/Qt4Qt5/qscintilla.pro)
	local major=${version%%.*}
	if [[ ${subslot} != ${major} ]]; then
		eerror
		eerror "Ebuild sub-slot (${subslot}) does not match QScintilla major version (${major})"
		eerror "Please update SLOT variable as follows:"
		eerror "    SLOT=\"${SLOT%%/*}/${major}\""
		eerror
		die "sub-slot sanity check failed"
	fi
}

src_prepare() {
	if use qt5; then
		epatch "${FILESDIR}/qt5_libname.patch"
		epatch "${FILESDIR}/qt5_mkspecs_path.patch"
	fi
}

src_configure() {
	mkdir -p QSciQt4
	cp -r Qt4Qt5/* QSciQt4
	pushd QSciQt4 > /dev/null
	eqmake4 DESTDIR=../QSciQt4
	popd > /dev/null

	if use designer; then
		# prevent building against system version (bug 466120)
		append-cxxflags -I../QSciQt4
		append-ldflags -L../QSciQt4
		
		mkdir designer-Qt4
		pushd designer-Qt4 > /dev/null
		eqmake4 INCLUDEPATH+=../Qt4Qt5 QMAKE_LIBDIR+=../QSciQt4 DESTDIR=../designer-Qt4
		popd > /dev/null
	fi

	if use qt5; then
		mkdir -p QSciQt5
		cp -r Qt4Qt5/* QSciQt5
		pushd QSciQt5 > /dev/null
		eqmake5 DESTDIR=../QSciQt5
		popd > /dev/null

		if use designer; then
			# prevent building against system version (bug 466120)
			append-cxxflags -I../QSciQt5
			append-ldflags -L../QSciQt5

			cp -r designer-Qt4Qt5 designer-Qt5
			pushd designer-Qt5 > /dev/null
			eqmake5 INCLUDEPATH+=../Qt4Qt5 QMAKE_LIBDIR+=../QSciQt5 DESTDIR=../designer-Qt5
			popd > /dev/null
		fi
	fi
}

src_compile() {
	pushd QSciQt4 > /dev/null
	emake
	popd > /dev/null

	if use designer; then
		pushd designer-Qt4 > /dev/null
		emake
		popd > /dev/null
	fi
	if use qt5; then
		pushd QSciQt5 > /dev/null
		emake
		popd > /dev/null

		if use designer; then
			pushd designer-Qt5 > /dev/null
			emake
			popd > /dev/null
		fi
	fi
}

src_install() {
	pushd QSciQt4 > /dev/null
	emake INSTALL_ROOT="${D}" install
	popd > /dev/null

	if use designer; then
		pushd designer-Qt4 > /dev/null
		emake INSTALL_ROOT="${D}" install
		popd > /dev/null
	fi

	if use qt5; then
		pushd QSciQt5 > /dev/null
		emake INSTALL_ROOT="${D}" install
		popd > /dev/null

		if use designer; then
			pushd designer-Qt5 > /dev/null
			emake INSTALL_ROOT="${D}" install
			popd > /dev/null
		fi
	fi

	dodoc NEWS

	if use doc; then
		docinto html
		dodoc -r doc/html-Qt4Qt5/*
	fi
}
