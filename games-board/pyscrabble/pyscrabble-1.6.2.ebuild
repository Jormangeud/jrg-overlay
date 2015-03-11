# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python games

DESCRIPTION="An online multiplayer Scrabble game. It supports English, French, German and Serbian languages and games."
HOMEPAGE="http://pyscrabble.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/python"
RDEPEND="virtual/python
	dev-python/pygame
	dev-python/nevow
	dev-python/pygtk"

pkg_setup() {
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/${PN}-create_config_dir.patch

	#correct the resource path
	sed -i -e "s:RESOURCE_PREFIX = 'resources':RESOURCE_PREFIX = \
	'"${GAMES_LIBDIR}"/${PN}/resources':" pyscrabble/dist.py \
	|| die "sed failed"

	#put config files in .pyscrabble directory
	sed -i -e "s:'.config',  APP_NAME:'.' + APP_NAME:" pyscrabble/dist.py \
	|| die "sed failed"
}

src_install() {
	insinto "${GAMES_LIBDIR}"/${PN}
	doins -r *.py || die "copy failed"
	doins -r resources || die "copy failed"
	doins -r pyscrabble || die "copy failed"

	fperms 0750 "${GAMES_LIBDIR}"/${PN}/pyscrabble-main.py
	games_make_wrapper ${PN} "python ${GAMES_LIBDIR}/${PN}/pyscrabble-main.py"

	doicon resources/images/pyscrabble.xpm
	make_desktop_entry pyscrabble pyScrabble pyscrabble.xpm 'Game;BoardGame'

	dodoc CHANGELOG.txt README.txt PKG-INFO

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	python_mod_optimize "${GAMES_LIBDIR}"/${PN}
}

pkg_postrm() {
	python_mod_cleanup "${GAMES_LIBDIR}"/${PN}
}
