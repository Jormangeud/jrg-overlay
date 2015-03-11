# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs mercurial

DESCRIPTION="state-of-the-art document analysis and OCR system based on tesseract"
HOMEPAGE="http://code.google.com/p/ocropus/"
EHG_REPO_URI="https://ocropus.googlecode.com/hg/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=app-text/tesseract-2
	media-libs/tiff
	media-libs/libpng
	media-libs/jpeg
	sci-libs/gsl
	=media-libs/iulib-9999"

src_compile() {
	cd "${WORKDIR}/hg"
	sed -i 's#<ocropus/ocr-utils.h>#<ocr-utils.h>#' ocr-line/glclass.cc
	epatch "${FILESDIR}"/ocr-voronoi_tiff_version.patch
	tc-export CC CXX
	scons omp=1 prefix=/usr || die
}

src_install() {
	cd "${WORKDIR}/hg"
	scons omp=1 prefix=/usr destdir=${D} install || die
	dodoc COPYING DIRS CHANGES README
}
