# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="dnsname plugin for podman"
HOMEPAGE="https://github.com/containers/dnsname"
SRC_URI="https://github.com/containers/dnsname/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	emake LDFLAGS="" || die
}

src_install() {
	exeinto /opt/cni/bin
	doexe bin/*
	dodoc README.md
}
