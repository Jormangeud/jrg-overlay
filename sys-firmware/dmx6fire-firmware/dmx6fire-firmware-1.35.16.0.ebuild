# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Terratec DMX 6Fire USB firmware"
HOMEPAGE="https://www.terratec.de/"
MY_PN="DMX_6fire_USB"
MY_PV="10546-81"
SRC_URI="http://terratec.ultron.info/Audio/${MY_PN}/Updates/${MY_PV}.exe -> ${P}.exe"
LICENSE=""
SLOT="0"
KEYWORDS="" # not tested

DEPEND="app-arch/p7zip"

S=${WORKDIR}

# bfe471af9f4ded99a70e7f91aa786ba7  ttdmx6fireap.ihx
# 0fdac0d4835f52679a1bb2db4fe61be3  ttdmx6firel2.ihx
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
