# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/festival-fi/festival-fi-20041119.ebuild,v 1.5 2012/10/19 19:15:29 ago Exp $

EAPI="2"
inherit eutils

DESCRIPTION="Finnish diphones and text to speech script for festival"
HOMEPAGE="http://www.ling.helsinki.fi/suopuhe"
OLD_PV="20041119"
SRC_URI="http://www.ling.helsinki.fi/suopuhe/download/hy_fi_mv_diphone-${OLD_PV}.tgz
	http://phon.joensuu.fi/suopuhe/tulosaineisto/suo_fi_lj-1.0g-${PV}.tgz
	http://www.ling.helsinki.fi/suopuhe/download/lavennin-${OLD_PV}.tgz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lavennin"

RDEPEND=">=app-accessibility/festival-1.96_beta"
DEPEND=""

src_prepare(){
	epatch "${FILESDIR}/${P}_debian_patches.patch"

	cd "${WORKDIR}/lavennin/bin"
	epatch "${FILESDIR}/${PN}-${OLD_PV}_lavennin_path.patch"
}

src_install() {
	cd "${WORKDIR}"
	# recode the readme, lj is newer than mv
	iconv -f ISO-8859-1 -t UTF-8 festival/lib/voices/finnish/suo_fi_lj_diphone/README.lj -o README
	newdoc README
	# remove the older 2004 stuff, the 2005 package has newer definitions
	rm -fr festival/lib/voices/finnish/hy_fi_mv_diphone/{festvox,README.mv,LICENSE}
	rm festival/lib/voices/finnish/suo_fi_lj_diphone/{README.lj,LICENSE}
	insinto /usr/share/festival/
	cd festival/lib/
	doins -r voices/
	# link to the lj stuff from the mv
	dosym ../suo_fi_lj_diphone/festvox /usr/share/festival/lib/voices/finnish/hy_fi_mv_diphone/festvox

	if use lavennin; then

		cd "${WORKDIR}/lavennin/"
		newdoc README.txt README.lavennin
		docinto lavennin
		mv man/index.shtml man/index.html
		dodoc man/*html

		# using lavennin as the executable name rather than patching the docs.
		newbin bin/lavennin
		dodir /usr/share/suopuhe/data/
		insinto /usr/share/suopuhe
		doins data/*.txt

	fi
}
