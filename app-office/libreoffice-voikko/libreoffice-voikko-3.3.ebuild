# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils versionator multilib

DESCRIPTION="Free Finnish spell checking and hyphenation for OpenOffice"
IUSE=""
HOMEPAGE="http://voikko.sf.net/"
SRC_URI="mirror://sourceforge/voikko/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=app-office/libreoffice-3.5[odk]
	>=app-text/voikko-3.0"


RDEPEND=">=app-office/libreoffice-3.5
	>=app-text/voikko-3.0"


pkg_setup() {
	if pidof soffice.bin >/dev/null; then
		ewarn "${PN} may not be installed while LibreOffice is running."
	fi
	
	LIBREOFFICE_SDK_DIR="${ROOT}/usr/lib/libreoffice/sdk"
	einfo "Setting SDK environment from "
	einfo "${LIBREOFFICE_SDK_DIR}/setsdkenv_unix.sh"
	source "${LIBREOFFICE_SDK_DIR}"/setsdkenv_unix.sh
	export UNOPKG="${ROOT}"/usr/bin/unopkg
}

#src_compile() {
#	emake oxt
#}

src_install() {
	dodoc README ChangeLog
	emake DESTDIR="${D}/usr/$(get_libdir)/${P}" install-unpacked
	insinto /usr/$(get_libdir)/libreoffice/share/extension/install/
	doins build/voikko.oxt
}

# FIXME: installation of an unopkg is troublesome, move to src_install when
# OO.o supports it somehow sanely
pkg_postinst() {
	# N.B.: uno packages meddle with $HOME, let’s fool it
	HOME="${S}"
	cd "${S}"

	# select component
	COMPONENT="${ROOT}/usr/$(get_libdir)/libreoffice/share/extension/install/voikko.oxt"

	einfo "Trying to register ${COMPONENT}..."
	HOME=${HOME} "${UNOPKG}" add --shared "${COMPONENT}"
	if [[ $? == 0 ]] ;
	then
		einfo "${PN} package registered succesfully"
	else
		eerror "Couldn’t register ${PN} package "
	fi
	elog "Please note that ${PN} is very dependent on ABI compatible "
	elog "version of LibreOffice to exist on system when removing ${PN}!"
	elog "Before any incompatible update or removal of LibreOffice you must"
	elog "unmerge ${PN}!"
}

pkg_prerm() {
	#unregister()
	UNOPKG_LIST="$(${UNOPKG} list --shared 2> /dev/null)"
	if [[ $? != 0 ]] ; then
		ewarn "Couldn’t list existing packages..."
	fi
	PKG=$(echo "${UNOPKG_LIST}" | egrep -m1 "^Identifier: (org.puimula.ooovoikko|org.libreoffice.legacy.libreoffice-voikko.*.uno.pkg)" | sed -ne "s/^Identifier: \\(.*\\)/\\1/p")
	if [ "${PKG}" != "" ]; then
		einfo "Removing uno package ${PKG}..."
		if "${UNOPKG}" remove --shared ${PKG} &>/dev/null
		then
			einfo "${PN} package (${PKG}) unregistered succesfully"
		else
			die "Couldn’t uninstall existing ${PN} packages"
		fi
	else
		ewarn "Couldn’t find existing ${PN} packages."
		ewarn "You may need to \`unopkg remove\` them manually."
	fi
}
