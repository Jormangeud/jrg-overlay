# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils versionator autotools

MY_PV="$(get_version_component_range 1-3)"
S="${WORKDIR}/${PN}"


DESCRIPTION="Drivers for Epson printers"
HOMEPAGE="http://www.avasys.jp/lx-bin2/linux_e/spc/DL1.do"
SRC_URI="http://linux.avasys.jp/drivers/${PN}/${MY_PV}/${PN}_$(replace_version_separator 3 -).tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk"

DEPEND="net-print/cups
	gtk? ( x11-libs/gtk+ )"
RDEPEND="${DEPEND}"
RESTRICT="mirror strip"
MAKEOPTS=-j1

src_unpack() {
	unpack ${A}
	cd ${S}
	if ! use gtk ; then epatch "${FILESDIR}"/"${PN}"-no-gtk.patch; fi
        eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	cd "${D}"

	doinitd ${FILESDIR}/pipslited

	# make needed symlinks
#	dosym /usr/$(get_libdir)/cups/backend/pipslitelp usr/libexec/cups/backend/pipslitelp
	
	for i in usr/$(get_libdir)/pipslite/* ; do
		dosym /${i} usr/bin/$(echo ${i} | sed -e "s/usr\/$(get_libdir)\/pipslite\///") #"
	done
	
#	for i in usr/libexec/cups/filter/* ; do
#		dosym /${i} ${i}
#	done
	
	# remove init scripts for other distros
	rm -rf usr/{bin,lib,share}/pipslite/{rc.d,scripts}

	# remove useless
	rm -rf var
}

pkg_postinst() {
	einfo "To install a ppd file for your printer, run"
	einfo "     /etc/init.d/pipslited start"
	einfo "     pipslite-install"
}
