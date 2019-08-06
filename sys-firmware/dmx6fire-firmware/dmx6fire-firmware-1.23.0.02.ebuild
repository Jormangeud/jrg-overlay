# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Terratec DMX 6Fire USB firmware"
HOMEPAGE="https://www.terratec.de/"
SRC_URI="http://terratec.ultron.info/Audio/DMX_6fire_USB/Updates/History/Windows/DMX_6fire_USB_Setup_1.23.0.02_XP_Vista_7.exe -> ${P}.exe"
LICENSE=""
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="app-arch/p7zip"

S=${WORKDIR}


src_unpack() {
	for exe in ${A} ; do
		echo ">>> Unpacking ${exe} to ${WORKDIR}"
		7z e -aot -o"${WORKDIR}/tmp" "${DISTDIR}"/${exe} > /dev/null \
			|| die "failed to unpack ${exe}"
	done

	declare -A FW=( [fa80973cb8c02097712933bd1d1c23b2]=dmx6firel2.ihx
					[7497b6b80d43e68f13b6929934ab60f4]=dmx6fireap.ihx
					[a65eecc11adc87af7307f5266ad31d65]=dmx6firecf.bin )
	for i in "${WORKDIR}"/tmp/* ; do
		s=$(md5sum ${i} | awk '{ print $1 }')
		if [ ${FW[$s]+_} ] ; then
			mv ${i} ${WORKDIR}/${FW[$s]}
			unset ${FW[$s]}
		fi
	done
}

src_install() {
	dodir /lib/firmware/6fire
	insinto /lib/firmware/6fire
	doins dmx6firel2.ihx dmx6fireap.ihx dmx6firecf.bin
}
