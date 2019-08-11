# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Terratec DMX 6Fire USB firmware"
HOMEPAGE="https://www.terratec.de/"
MY_PN="DMX_6fire_USB"
MY_PV="10546-32"
SRC_URI="http://terratec.ultron.info/Audio/${MY_PN}/Updates/${MY_PV}.exe -> ${P}.exe"
LICENSE=""
SLOT="0"
KEYWORDS="" # not tested

DEPEND="app-arch/p7zip"

S=${WORKDIR}

# 56768b63e6f2351817b4ccc8db13649c  ttdmx6fireap.ihx
# 81886efb0cf83f52a8e7460f33779c8e  ttdmx6firel2.ihx
# f82fbe13a3955572eaecfc344e96bee2  ttdmx6firecf.bin

src_unpack() {
	for exe in ${A} ; do
		echo ">>> Unpacking ${exe} to ${WORKDIR}"
		7z e -aot -o"${WORKDIR}" "${DISTDIR}"/${exe} > /dev/null \
			|| die "failed to unpack ${exe}"
	done
}

src_install() {
	dodir /lib/firmware/6fire
	insinto /lib/firmware/6fire
	doins dmx6firel2.ihx dmx6fireap.ihx dmx6firecf.bin
}
