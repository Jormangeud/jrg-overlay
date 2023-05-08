# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit linux-info meson udev systemd python-r1


if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


DESCRIPTION="Library to configure gaming mice"
HOMEPAGE="https://github.com/libratbag/libratbag"

LICENSE="MIT"
SLOT="0"
IUSE="doc systemd test"
RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}
	dev-libs/libevdev
	dev-python/python-evdev[${PYTHON_USEDEP}]
	virtual/libudev
	systemd? ( sys-apps/systemd )
	!systemd? ( sys-auth/elogind )
"

DEPEND="${RDEPEND}
	dev-lang/swig
	dev-libs/glib
	dev-libs/json-glib
	dev-libs/libunistring
	virtual/pkgconfig
	doc? ( dev-python/sphinx )
"

#PATCHES=( ${FILESDIR}/python3-config.patch )

pkg_setup() {
	linux-info_pkg_setup

	CONFIG_CHECK="~HIDRAW"
	check_extra_config
}

src_prepare() {
	default

	sed '/default:/d' -i meson_options.txt || die
}

src_configure() {
	local emesonargs=(
		-Ddocumentation=$(usex doc true false)
		-Dtests=$(usex test true false)
		-Dudev-dir=$(get_udevdir)
		-Dsystemd-unit-dir=$(systemd_get_systemunitdir)
		-Dsystemd=$(usex systemd true false)
		-Dlogind-provider=$(usex systemd systemd elogind)
	)
	meson_src_configure
}

src_install() {
	default
	newinitd "${FILESDIR}/ratbagd.init" ratbagd
}
