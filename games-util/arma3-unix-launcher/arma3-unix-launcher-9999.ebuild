# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/muttleyxd/${PN}.git"
	KEYWORDS=""
else
	#SRC_URI="/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="ArmA 3 Unix Launcher"
HOMEPAGE="https://github.com/muttleyxd/arma3-unix-launcher"
LICENSE="MIT"
SLOT="0"
IUSE="+debug"

RDEPEND=">=dev-cpp/gtkmm-3.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/0001-Fix-differing-meta-mod-name.patch"
)

