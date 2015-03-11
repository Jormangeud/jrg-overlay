# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib

MY_PV=${PV/_rc/rc}
MY_P=${PN}-voikko-${MY_PV}

DESCRIPTION="An interface between ispell and Voikko Finnish spellcheckers."
SRC_URI="mirror://sourceforge/voikko/${MY_P}.tar.gz"
HOMEPAGE="http://voikko.sf.net/"
IUSE="nls"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND=">=app-text/ispell-3.3.02-r90
	!app-dicts/ispell-fi
	>=app-text/voikko-1.0
	>=dev-libs/glib-2.0.0
	>=dev-cpp/glibmm-2.4
	sys-apps/miscfiles
	dev-util/pkgconfig
	app-admin/eselect-ispell"
RDEPEND=">=app-text/ispell-3.3.02-r90
	>=app-text/voikko-1.0
	>=dev-libs/glib-2.0.0
	>=dev-cpp/glibmm-2.4"

S="${WORKDIR}/${MY_P/rc?/}"

pkg_setup() {
	if [[ -d "${ROOT}/usr/$(get_libdir)/ispell" ]] ; then
		ISPELL_DIR=/usr/$(get_libdir)/ispell
	elif [[ -d "${ROOT}/usr/share/ispell" ]] ; then
		ISPELL_DIR=/usr/share/ispell
	else
		die "Couldn’t find ispell data directory from root ${ROOT}"
	fi
	einfo "Using ${ISPELL_DIR} for ispell data"
}

src_compile() {
	# unconditional disable-enchant: provider is included in enchant-1.4
	econf --disable-enchant || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog README.fi NEWS README tmispell.conf.example ||\
		die "docs missing"
	insinto /etc/
	newins "${FILESDIR}/tmispell.conf.gentoo" tmispell.conf
	dodir ${ISPELL_DIR}
	touch "${D}/${ISPELL_DIR}/"{suomi,finnish}.{hash,aff}
}

pkg_postinst() {
	elog "Use “eselect ispell set tmispell” to get legacy applications"
	elog "which want ispell working with tmispell"
	eselect ispell update --if-unset
}

