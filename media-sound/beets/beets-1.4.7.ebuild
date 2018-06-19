# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{5,6} )
PYTHON_REQ_USE="sqlite"
inherit distutils-r1 eutils bash-completion-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
#	SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A media library management system for obsessive-compulsive music geeks"
HOMEPAGE="http://beets.io/ https://pypi.python.org/pypi/beets"

SLOT="0"
LICENSE="MIT"
IUSE="badfiles bpd bs1770gain chroma convert doc discogs flac gmusic gstreamer lastgenre lastimport metasync mpdstats opus rar replaygain test thumbnails web"
REQUIRED_USE="
	replaygain? ( || ( gstreamer bs1770gain ) )
	bpd? ( gstreamer )
"

RDEPEND="
	dev-python/jellyfish[${PYTHON_USEDEP}]
	dev-python/munkres[${PYTHON_USEDEP}]
	>=dev-python/python-musicbrainz-ngs-0.4[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/six-1.9[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]
	>=media-libs/mutagen-1.33[${PYTHON_USEDEP}]
	badfiles? ( media-sound/mp3val media-libs/flac )
	chroma? ( dev-python/pyacoustid[${PYTHON_USEDEP}] )
	convert? ( media-video/ffmpeg:0[encode] )
	discogs? ( >=dev-python/discogs-client-2.2.1[${PYTHON_USEDEP}] )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	mpdstats? ( dev-python/python-mpd[${PYTHON_USEDEP}] )
	lastgenre? ( dev-python/pylast[${PYTHON_USEDEP}] )
	lastimport? ( dev-python/pylast[${PYTHON_USEDEP}] )
	gmusic? ( dev-python/gmusicapi[${PYTHON_USEDEP}] )
	bs1770gain? ( media-sound/bs1770gain )
	gstreamer? ( media-libs/gstreamer:1.0[introspection]
		media-libs/gst-plugins-good:1.0
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		flac? ( media-plugins/gst-plugins-flac:1.0 )
		opus? ( media-plugins/gst-plugins-opus:1.0 )
	)
	metasync? ( dev-python/dbus-python[${PYTHON_USEDEP}] )
	rar? ( dev-python/rarfile )
	thumbnails? (
		dev-python/pyxdg[${PYTHON_USEDEP}]
		dev-python/pathlib2[${PYTHON_USEDEP}]
		|| ( dev-python/pillow[${PYTHON_USEDEP}] media-gfx/imagemagick )
	)
	web? ( dev-python/flask[${PYTHON_USEDEP}] dev-python/flask-cors[${PYTHON_USEDEP}] )
	$(python_gen_cond_dep '>=dev-python/enum34-1.0.4[${PYTHON_USEDEP}]' 'python2*')
"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	# remove plugins that do not have appropriate dependencies installed
	for flag in bpd chroma convert discogs gmusic lastgenre lastimport mpdstats replaygain thumbnails web; do
		if ! use ${flag}; then
			rm -r beetsplug/${flag}.py || \
			rm -r beetsplug/${flag}/ ||
				die "Unable to remove ${flag} plugin"
		fi
	done

	for flag in bpd lastgenre web; do
		if ! use ${flag}; then
			sed -e "s:'beetsplug.${flag}',::" -i setup.py || \
				die "Unable to disable ${flag} plugin "
		fi
	done

	use bpd || rm -f test/test_player.py

	default
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	cd test
	if ! use web; then
		rm test_web.py || die "Failed to remove test_web.py"
	fi
	"${PYTHON}" testall.py || die "Testsuite failed"
}

python_install_all() {
	doman man/beet.1 man/beetsconfig.5
	use doc && dohtml -r docs/_build/html/

	distutils-r1_python_install_all

	cd "${D}${PYTHON_SITEDIR}"
	"${EPYTHON}" -m beets completion > ${S}/bashcomp
	newbashcomp "${S}/bashcomp" beet
}
