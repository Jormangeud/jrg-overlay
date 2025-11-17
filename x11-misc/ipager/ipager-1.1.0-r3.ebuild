# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{6..11} )

inherit python-any-r1 scons-utils

DESCRIPTION="A themable desktop pager for fluxbox and other window managers"
HOMEPAGE="https://github.com/artb/ipager"
SRC_URI="https://github.com/artb/ipager/archive/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xinerama debug"

RDEPEND="media-libs/imlib2[X]
	x11-libs/libXmu
	xinerama? ( x11-libs/libXinerama )"

DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}
	dev-util/scons"

S="${WORKDIR}/${PN}-${P}"

PATCHES=(
	"${FILESDIR}"/${P}-scons_imlib2.patch
	#"${FILESDIR}"/${P}-scons_flags.patch
	"${FILESDIR}"/${P}-gcc43.patch
	"${FILESDIR}"/${P}-gcc47.patch
	"${FILESDIR}"/${P}-pager.patch
	"${FILESDIR}"/${P}-m_buffer_icons.patch
	"${FILESDIR}"/${P}-SConstruct.patch
	"${FILESDIR}"/${P}-opacity.patch
	"${FILESDIR}"/${P}-SConstruct3.patch
)

src_compile() {
	CONFIG_OPTS="xinerama=false"
	use xinerama && CONFIG_OPTS="${CONFIG_OPTS} xinerama=true"
	# FYI: Passing debug=true only adds -ggdb inside the SConstruct

	use debug && CONFIG_OPTS="${CONFIG_OPTS} debug=true debug_events=true"

	escons \
		--cache-disable \
		PREFIX="/usr" \
		${CONFIG_OPTS} \
		|| die "scons configure failed"
}

src_install() {
	escons \
		--cache-disable \
		PREFIX="/usr" \
		DESTDIR="${D}" \
		install \
		|| die "scons install failed"
	dodoc ToDo ChangeLog README
	dodoc themes/*.conf
}
