# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


DESCRIPTION="CUPS driver for Brother HL-2040 printer"
HOMEPAGE=""
#SRC_URI="http://www.profv.de/brother/Brother-HL-2040-hl1250.ppd"
SRC_URI="https://njh.eu/Brother-HL-2040-hl1250.ppd"

RESTRICT="mirror"
LICENSE="GPL2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="net-print/cups-filters"
S="${WORKDIR}"

src_install() {

	# Install PPD file
	dodir /usr/share/cups/model/Brother
	insinto /usr/share/cups/model/Brother
	doins "${DISTDIR}"/Brother-HL-2040-hl1250.ppd

}
