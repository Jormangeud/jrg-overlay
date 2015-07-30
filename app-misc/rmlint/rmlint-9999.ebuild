# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib scons-utils toolchain-funcs eutils

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sahib/rmlint.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/PhotoBackup/server-flask/archive/${TAG}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/sahib/rmlint/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="rmlint finds space waste and other broken things on your filesystem and offers to remove it"

HOMEPAGE="https://github.com/sahib/rmlint/ http://rmlint.readthedocs.org/"

IUSE="doc nls"

RDEPEND="
	sys-libs/glibc
	>=dev-libs/glib-2.31
	dev-libs/json-glib
	sys-apps/util-linux
	dev-libs/elfutils
"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
        doc? ( dev-python/sphinx )"

SLOT="0"
LICENSE="GPL-3"

src_prepare() {
	epatch "${FILESDIR}/${PN}-SConstruct.patch"
	if ! use doc ; then
		sed -i -e "/SConscript('docs\/SConscript')/d" SConstruct || die "couldn't disable docs"
	fi
}

src_compile() {
	escons CC="$(tc-getCC)" --prefix=${D}/usr --actual-prefix=/usr --libdir=/usr/$(get_libdir)
}

src_install() {
	escons --prefix=${D}/usr --actual-prefix=/usr --libdir=/usr/$(get_libdir) install
}
