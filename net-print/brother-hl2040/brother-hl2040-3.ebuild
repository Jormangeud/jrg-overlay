# $Header: $

EAPI=3

inherit rpm autotools base

MY_PV="${PV}-1"

DESCRIPTION="CUPS driver for Brother HL-2040 printer"
HOMEPAGE=""
SRC_URI="http://www.profv.de/brother/Brother-HL-2040-hl1250.ppd"

RESTRICT="mirror"
LICENSE="GPL2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="|| ( net-print/foomatic-filters[cups] net-print/cups-filters )"

src_install() {

	# Install PPD file
	dodir /usr/share/cups/model/Brother
	insinto /usr/share/cups/model/Brother
	doins "${DISTDIR}"/Brother-HL-2040-hl1250.ppd

}
