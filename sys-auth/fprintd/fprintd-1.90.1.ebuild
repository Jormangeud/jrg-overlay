# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson pam systemd udev

DESCRIPTION="D-Bus service to access fingerprint readers"
HOMEPAGE="https://cgit.freedesktop.org/libfprint/fprintd/"
SRC_URI="https://gitlab.freedesktop.org/libfprint/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc pam static-libs systemd"

REQUIRED_USE="pam? ( systemd )"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	>=sys-auth/libfprint-${PV}
	sys-auth/polkit
	pam? ( sys-libs/pam )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	dev-util/intltool
	doc? ( dev-libs/libxml2 dev-libs/libxslt )
"

BDEPEND="virtual/pkgconfig"

#S="${WORKDIR}/${PN}-v${PV}"

src_configure() {
		local emesonargs=(
			-Dpam=$(usex pam true false)
			-Dsystemd_system_unit_dir="$(systemd_get_systemunitdir)"
			-Dpam_modules_dir=$(getpam_mod_dir)

		)
		meson_src_configure
}

