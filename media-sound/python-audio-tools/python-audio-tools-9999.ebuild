# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

inherit distutils-r1 eutils

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tuffy/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/tuffy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


DESCRIPTION="Python Audio Tools are a collection of audio handling programs which work from the command line"
HOMEPAGE="http://audiotools.sourceforge.net/
	https://github.com/tuffy/python-audio-tools"

LICENSE="GPL-2+"
SLOT="0"

IUSE="aac alsa cdio cdr cover cue dvd encode interactive mp2 mp3 ogg opus pulseaudio replaygain wavpack"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	aac? ( || ( media-sound/neroaac ( encode? ( media-libs/faac ) media-libs/faad2 ) ) )
	cdio? ( dev-libs/libcdio-paranoia )
	cdr? ( cue? ( app-cdr/cdrdao ) app-cdr/cdrtools )
	cover? ( dev-lang/python[tk] dev-python/pillow[${PYTHON_USEDEP}] )
	dvd? ( media-sound/libdvd-audio )
	interactive? ( dev-python/urwid[${PYTHON_USEDEP}] )
	mp2? ( media-sound/mpg123 encode? ( media-sound/twolame ) )
	mp3? ( media-sound/mpg123 encode? ( media-sound/lame ) replaygain? ( media-sound/mp3gain ) )
	ogg? ( media-libs/libvorbis replaygain? ( media-sound/vorbisgain ) )
	opus? ( media-libs/opusfile encode? ( media-libs/opus ) )
	wavpack? ( media-sound/wavpack )
"
RDEPEND="${DEPEND}"
