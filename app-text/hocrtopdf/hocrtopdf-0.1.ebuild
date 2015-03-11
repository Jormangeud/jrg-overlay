# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="utility to make PDF from the html output of OCRopus"
HOMEPAGE="http://bugs.gentoo.org/show_bug.cgi?id=185810#c35"
SRC_URI="http://bugs.gentoo.org/attachment.cgi?id=203108&rename=/${P}.tar.gz"
# use this ebuild with GENTOO_MIRRORS="" 

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/reportlab
   dev-python/pyxml"
RDEPEND="${DEPEND}"

src_install() {
	into /usr/local
	dobin usr/local/bin/hocrtopdf
	# tar zcf /usr/portage/distfiles/hocrtopdf-0.1.tgz /usr/local/bin/hocrtopdf
}

