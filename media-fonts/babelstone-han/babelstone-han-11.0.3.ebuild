# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

MY_PN="BabelStoneHan"

DESCRIPTION="Free Unicode CJK font with over 36,000 Han characters (hanzi, kanji, hanja)"
HOMEPAGE="http://www.babelstone.co.uk/Fonts/Han.html"
SRC_URI="http://www.babelstone.co.uk/Fonts/Download/${MY_PN}.zip -> ${P}.zip"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="binchecks strip test"

S="${WORKDIR}"
FONT_SUFFIX="ttf"
