# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/amaya/amaya-9.52.ebuild,v 1.1 2006/10/19 08:35:28 platinumviper Exp $

inherit libtool eutils

S=${WORKDIR}/Amaya/WX

DESCRIPTION="The W3C Web-Editor/Browser"
SRC_URI="http://www.w3.org/Amaya/Distribution/${PN}-sources-${PV}.tgz"
HOMEPAGE="http://www.w3.org/Amaya/"

KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
SLOT="9"
IUSE="gl debug"

RDEPEND="virtual/opengl
	virtual/x11
	media-libs/imlib
	>=x11-libs/gtk+-2.0
	gl? ( >=media-libs/freetype-2 )"

DEPEND="dev-lang/perl
	dev-libs/openssl
	${RDEPEND}"

src_compile() {
	local myconf=""
	mkdir ${S}
	cd ${S}
	if use gl ;then
		myconf="${myconf} --with-gl"
	fi
	if use debug ;then
	    myconf="${myconf} --with-debug --with-wxdebug"
	fi
	myconf="${myconf} --with-wx"
	../configure \
		${myconf} \
		--prefix=/usr
	make || die
}

src_install () {
	dodir /usr
	make prefix=${D}/usr install || die
}
