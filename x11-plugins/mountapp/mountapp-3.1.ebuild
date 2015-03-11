DESCRIPTION="mount filesystems via an easy-to-use windowmaker applet"
HOMEPAGE="http://mountapp.sourceforge.net"
SRC_URI="http://mountapp.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE=""

DEPEND="virtual/libc
	=x11-libs/gtk+-1.2*
	>=x11-wm/windowmaker-0.80"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO

}
