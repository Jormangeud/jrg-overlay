EAPI=7

DESCRIPTION="Control SteelSeries Apex keyboards on GNU/Linux"
HOMEPAGE="https://github.com/AstroSnail/apexctl"
COMMIT="b1e894cd7d7aa067f5dfa492e88c99708163c7d1"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AstroSnail/apexctl.git"
	KEYWORDS=""
else
#	SRC_URI="https://github.com/AstroSnail/apexctl/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/AstroSnail/apexctl/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="Apache-2.0"
SLOT=0
IUSE=""

RDEPEND="virtual/udev
	dev-libs/hidapi"

DEPEND="${RDEPEND}"

src_unpack() {
        default
        mv ${WORKDIR}/apexctl-master ${WORKDIR}/${P}
}

src_install() {
        # override install.sh in Gentoo way
        dobin apexctl

        insinto /lib/udev/hwdb.d
        insopts -m0644
        newins 00-apex.hwdb 90-apex.hwdb

        insinto /lib/udev/rules.d
        insopts -m0644
        newins 00-apexctl.rules 90-apexctl.rules

        insinto /etc/X11/xorg.conf.d
        insopts -m0644
        newins 00-apex.conf 90-apex.conf
}

pkg_postinst() {
        udevadm hwdb --update
        udevadm trigger
}
