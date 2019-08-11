# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Terratec DMX 6Fire USB firmware"
HOMEPAGE="https://www.terratec.de/"

MY_PN="DMX_6fire_USB"
SRC_URI="http://terratec.ultron.info/Audio/${MY_PN}/Updates/History/Windows/${MY_PN}_Setup_${PV}_XP_Vista_7.exe -> ${P}.exe"
LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="app-arch/p7zip"

S=${WORKDIR}


src_unpack() {
	for exe in ${A} ; do
		echo ">>> Unpacking ${exe} to ${WORKDIR}"
		7z e -aot -o"${WORKDIR}/tmp" "${DISTDIR}"/${exe} > /dev/null \
			|| die "failed to unpack ${exe}"
	done

	declare -A FW=( [c609e31bf28253f4c5f61e5e2ee2e81b]=dmx6firel2.ihx
					[bd3801d850776b6083d88a2915896566]=dmx6fireap.ihx
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
