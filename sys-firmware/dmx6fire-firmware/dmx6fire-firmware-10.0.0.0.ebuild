# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Terratec DMX 6Fire USB firmware"
HOMEPAGE="https://www.terratec.de/"
SRC_URI="http://terratec.ultron.info/Audio/DMX_6fire_USB/Updates/win10_drv.zip -> ${P}.zip"
LICENSE=""
SLOT="0"
KEYWORDS="" # These firmware files do not work with the in kernel module as of 5.2.6


S=${WORKDIR}

# ebded3c71d02bea5e3ecdf67d5cec878  ttdmx6fireap.ihx
# 544c584a076c522f3c03bbb0ec265b64  ttdmx6firel2.ihx
# f82fbe13a3955572eaecfc344e96bee2  ttdmx6firecf.bin

src_install() {
	dodir /lib/firmware/6fire
	insinto /lib/firmware/6fire
	doins ttdmx6fireap.ihx ttdmx6firel2.ihx ttdmx6firecf.bin
}
