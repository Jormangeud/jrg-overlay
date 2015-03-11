inherit eutils toolchain-funcs

DESCRIPTION="a dockapp that displays and (un)mounts hotplug devices and removable media."
HOMEPAGE="http://dockapps.windowmaker.org/file.php/id/275"
SRC_URI="http://dockapps.windowmaker.org/download.php/id/851/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/libdockapp-0.6
	x11-libs/libX11
	dev-libs/dbus-glib
	>=sys-fs/udisks-1.0.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README
}

