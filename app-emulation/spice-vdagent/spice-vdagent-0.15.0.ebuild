EAPI=4

inherit linux-info

DESCRIPTION="SPICE VD Linux Guest Agent."
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+consolekit selinux systemd"
REQUIRED_USE="^^ ( consolekit systemd )"

RDEPEND="x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libX11
	x11-libs/libXinerama
	>=x11-libs/libpciaccess-0.10
	>=app-emulation/spice-protocol-0.12.5
	consolekit? ( sys-auth/consolekit sys-apps/dbus )
	selinux? ( sec-policy/selinux-vdagent )
	systemd? ( sys-apps/systemd )"

DEPEND="virtual/pkgconfig
	${RDEPEND}"

CONFIG_CHECK="~INPUT_UINPUT ~VIRTIO_CONSOLE"
ERROR_INPUT_UINPUT="User level input support is required"
ERROR_VIRTIO_CONSOLE="VirtIO console/serial device support is required"

src_configure() {
	local opt=

	use consolekit && opt="${opt} --with-session-info=console-kit"
	use systemd && opt="${opt} --with-session-info=systemd --with-init-script=systemd"

	econf \
		--localstatedir=/var \
		${opt}
}

src_install() {
	default

	rm -rf "${D}"/etc/{rc,tmpfiles}.d

	keepdir /var/log/spice-vdagentd

	newinitd "${FILESDIR}/${PN}.initd-2" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd-2" "${PN}"
}
