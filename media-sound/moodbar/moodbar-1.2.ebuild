# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/exaile/moodbar.git"
else
	SRC_URI="https://github.com/exaile/${PN}/releases/download/v${PV/_/-}/${PN}-${PV/_/}.tar.xz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/${PN}-${PV/_/}"
fi

DESCRIPTION="Audio timeline visualization"
HOMEPAGE="https://github.com/exaile/moodbar"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	sci-libs/fftw:3.0
	>=media-libs/gst-plugins-base-1.6:1.0
	>=media-libs/gst-plugins-bad-1.4:1.0
	>=media-libs/gst-plugins-good-1.4:1.0
	>=media-libs/gst-plugins-ugly-1.4:1.0
"

RESTRICT="test"
