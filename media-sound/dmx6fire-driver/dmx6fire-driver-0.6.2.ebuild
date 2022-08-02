# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info linux-mod eutils

DESCRIPTION="ALSA Kernel module for the TerraTec DMX 6Fire USB soundcard"
HOMEPAGE="http://sourceforge.net/projects/sixfireusb"

MY_PN="sixfireusb"
MY_P="${MY_PN}-${PV}"

SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.bz2"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2+"
SLOT="0"

S=${WORKDIR}/${MY_P}

DOCS=( "${S}/CHANGES" "${S}/README" )

RDEPEND=">=sys-firmware/dmx6fire-firmware-1.23.0.02"

MODULE_NAMES="snd-usb-6fire(kernel/sound/usb/6fire:${S})"
BUILD_TARGETS="modules"

src_prepare() {
	sed -i -e "s:\$(KERNELRELEASE):${KV_FULL}:" Makefile || die "sed failed!"

	PATCH_KV=7
	if [ "${KV_MINOR}" -lt 7 ]; then
		PATCH_KV=1
	fi
	if [ "${KV_MINOR}" -ge 9 ]; then
		PATCH_KV=9
	fi
	if [ "${KV_MINOR}" -ge 12 ]; then
		PATCH_KV=12
	fi

	eapply "${FILESDIR}/${MY_P}-kernel-${KV_MAJOR}.${PATCH_KV}.patch" || die "patch failed!"
	eapply_user
}

pkg_setup() {
	linux-mod_pkg_setup
}

src_compile() {
	BUILD_PARAMS="KERNELDIR=${KERNEL_DIR}"
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}
