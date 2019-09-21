# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="Linuxhttp_V$(ver_rs 3 '_')"

DESCRIPTION="ArcHTTP proxy utility to manage Areca RAID controllers"
HOMEPAGE="https://www.areca.com.tw/support/downloads.html#linux"
SRC_URI="http://www.areca.us/support/s_linux/http/${MY_P}.zip"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="${DEPEND}"

#RESTRICT="fetch"

S="${WORKDIR}/${MY_P}"

pkg_nofetch() {
	elog "Download the ArcHTTP file ${A} from
	https://www.areca.com.tw/support/downloads.html#linux"
	elog "and place it in your DISTDIR."
}

src_install() {
	local dir bin

	case ${ARCH} in
		amd64)
			dir="x86_64"
			bin="archttp64"
		;;
		x86)
			dir="i386"
			bin="archttp32"
		;;
		*)
			die "This arch is not supported."
		;;
	esac

	dodir /opt/${PN}
	exeinto /opt/${PN}
	newexe "${S}/${dir}/${bin}" areca_http
	dosym ../${PN}/areca_http /opt/bin/areca_http
}
