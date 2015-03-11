# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PV="${PV}-1"

DESCRIPTION="CUPS driver for Brother HL-2040 printer"
HOMEPAGE=""
SRC_URI="
http://www.brother.com/pub/bsc/linux/dlf/cupswrapperHL2040-${MY_PV}.i386.rpm
http://www.brother.com/pub/bsc/linux/dlf/brhl2040lpr-${MY_PV}.i386.rpm
"
#http://solutions.brother.com/Library/sol/printer/linux/rpmfiles/cups_wrapper/cupswrapperHL2040-${MY_PV}.i386.rpm
#http://solutions.brother.com/Library/sol/printer/linux/rpmfiles/lpr_others/brhl2040lpr-${MY_PV}.i386.rpm"

LICENSE="GPL2, as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-arch/rpm2targz
	sys-apps/gawk"
RDEPEND="net-print/cups
	sys-apps/sed"

function src_unpack() {
	rpm2tar ${DISTDIR}/cupswrapperHL2040-${MY_PV}.i386.rpm
	tar -xf cupswrapperHL2040-${MY_PV}.i386.tar

	rpm2tar ${DISTDIR}/brhl2040lpr-${MY_PV}.i386.rpm
	tar -xf brhl2040lpr-${MY_PV}.i386.tar

	# Extract PPD definition from wrapper installer
	ebegin 'Extracting PPD file'
	gawk '/^\*PPD-Adobe:/,/^\*End/' \
		${WORKDIR}/usr/local/Brother/cupswrapper/cupswrapperHL2040-${PV} \
		> ${WORKDIR}/HL2040.ppd
	eend

	# Use /usr/share/Brother instead of /usr/local/Brother as common root
	sed -i -e 's/\/usr\/local\/Brother/\/usr\/share\/Brother/' \
		${WORKDIR}/usr/local/Brother/lpd/filterHL2040
}

function src_install() {
	# Configuration binaries
	#  brprintconfiglpr2 can just be a symlink to brprintconflsr2
	exeinto /usr/bin
	doexe ${WORKDIR}/usr/bin/brprintconflsr2
	dosym brprintconflsr2 /usr/bin/brprintconfiglpr2

	# Install library file
	dolib ${WORKDIR}/usr/lib/*.so

	# Install PPD file
	dodir /usr/share/cups/model/Brother
	insinto /usr/share/cups/model/Brother
	doins ${WORKDIR}/HL2040.ppd

	# Install INF files
	dodir /usr/share/Brother/inf
	insinto /usr/share/Brother/inf
	cd ${WORKDIR}/usr/local/Brother/inf
	doins brHL2040func brHL2040rc paperinf

	# Install lpd files
	dodir /usr/share/Brother/lpd
	exeinto /usr/share/Brother/lpd
	cd ${WORKDIR}/usr/local/Brother/lpd
	doexe *

	# Install CUPS filter
	dodir /usr/libexec/cups/filter
	exeinto /usr/libexec/cups/filter
	newexe ${FILESDIR}/brlpdwrapperHL2040-${PV} brlpdwrapperHL2040
}

function pkg_postinst() {
	ewarn 'Brother has a tendency to hardcode printer names into its'
	ewarn 'configuration utilities. This driver may only work for a printer'
	ewarn 'named "HL2040"'
}

