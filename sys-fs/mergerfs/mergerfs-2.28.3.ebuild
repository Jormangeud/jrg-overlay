# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

MY_P="${PN}_${PV}"

DESCRIPTION="Featureful union filesystem"
HOMEPAGE="https://github.com/trapexit/mergerfs"
SRC_URI="https://github.com/trapexit/mergerfs/archive/${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND="
	sys-fs/fuse:0
"
DEPEND="${RDEPEND}"

DOCS=( README.md LICENSE )
