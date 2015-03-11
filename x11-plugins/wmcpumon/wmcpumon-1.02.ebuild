EAPI=4
inherit eutils toolchain-funcs

MY_PV="2011-05-02-14"
S="${WORKDIR}/${PN}"

DESCRIPTION="A multi CPU system monitor"
HOMEPAGE="http://wmcpumon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/Source/${PN}-${MY_PV}.tar.bz2"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libxcb
	>=x11-libs/xcb-util-0.3.8
	>=x11-libs/xcb-util-wm-0.3.8"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -DVERSION='\"${PV}\"'" \
		LDFLAGS="${LDFLAGS}" || die "emake failed."
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
