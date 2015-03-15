# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

DESCRIPTION="Tools and library for reading Outlook Express mailboxes (.dbx format)"
HOMEPAGE="http://sourceforge.net/projects/ol2mbox"
MY_P=${P/-/_}
SRC_URI="mirror://sourceforge/ol2mbox/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~amd64"

src_prepare() {
    sed -i -e 's/ -g / $(CFLAGS) $(LDFLAGS) /' Makefile
}

src_install() {
    dobin readoe readdbx ${FILESDIR}/dbx2mbox
    dodoc README* AUTHORS FILE-FORMAT
    insinto /usr/include
    doins libdbx*.h
    insinto /usr/lib
    doins libdbx.o
}
