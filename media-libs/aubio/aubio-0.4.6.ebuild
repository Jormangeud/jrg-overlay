# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DISTUTILS_OPTIONAL=1
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='threads(+)'

inherit distutils-r1 waf-utils multilib eutils

DESCRIPTION="Library for audio labelling"
HOMEPAGE="https://aubio.org/"
SRC_URI="https://aubio.org/pub/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0/5"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc double-precision examples ffmpeg fftw jack libav libsamplerate sndfile"

RDEPEND="
	ffmpeg? (
		!libav? ( >=media-video/ffmpeg-2.6:0= )
		libav? ( >=media-video/libav-9:0= )
	)
	fftw? ( sci-libs/fftw:3.0 )
	jack? ( virtual/jack )
	libsamplerate? ( media-libs/libsamplerate )
	sndfile? ( media-libs/libsndfile )
"
DEPEND="
	${RDEPEND}
	${PYTHON_DEPS}
	app-text/txt2man
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=( AUTHORS ChangeLog README.md )
PATCHES=( "${FILESDIR}/${PN}-0.4.6-ffmpeg4.patch" )

src_prepare() {
	default
	sed -i -e "s:doxygen:doxygen_disabled:" wscript || die
}

src_configure() {
	python_setup
	waf-utils_src_configure \
		--enable-complex \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable double-precision double) \
		$(use_enable fftw fftw3f) \
		$(use_enable fftw fftw3) \
		$(use_enable ffmpeg avcodec) \
		$(use_enable jack) \
		$(use_enable libsamplerate samplerate) \
		$(use_enable sndfile)

}

src_compile() {
	waf-utils_src_compile --notests

	if use doc; then
		cd "${S}"/doc || die
		emake dirhtml
	fi

}

src_test() {
	waf-utils_src_compile --alltests

}

src_install() {
	waf-utils_src_install

	if use examples; then
		# install dist_noinst_SCRIPTS from Makefile.am
		dodoc -r examples
	fi

	if use doc; then
		dodoc doc/*.txt
		docinto html
		dodoc -r doc/_build/dirhtml/.
	fi
}
