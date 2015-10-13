EAPI=4
inherit eutils toolchain-funcs

MY_PV="2011-04-29-17"
S="${WORKDIR}/${PN}"

DESCRIPTION="Core2Duo Temperature/Frequency Monitor"
HOMEPAGE="http://sourceforge.net/projects/wmc2d"
SRC_URI="mirror://sourceforge/${PN}/Source/${PN}-${MY_PV}.tar.bz2"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libxcb
	>=x11-libs/xcb-util-0.3.8
	>=x11-libs/xcb-util-wm-0.3.8"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch ${FILESDIR}/${P}_linux_3.15_coretemp.patch
	epatch ${FILESDIR}/${P}_xcb-1.10.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -DVERSION='\"${PV}\"'" \
		LDFLAGS="${LDFLAGS}" || die "emake failed."
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
