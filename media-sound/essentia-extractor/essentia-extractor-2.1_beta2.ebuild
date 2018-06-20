# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils


DESCRIPTION="This client lets you submit your own audio features to the AcousticBrainz project."
HOMEPAGE="http://acousticbrainz.org"

SRC_URI="
	amd64? ( http://acousticbrainz.org/static/download/${PN}-v${PV}-linux-x86_64.tar.gz )
	x86? ( http://acousticbrainz.org/static/download/${PN}-v${PV}-linux-i686.tar.gz )
"

KEYWORDS="~amd64 ~x86"

LICENSE="AGPL-3"
SLOT="0"
IUSE=""
DEPEND=""

QA_FLAGS_IGNORED="opt/${PN}/streaming_extractor_music"
QA_PRESTRIPPED=${QA_FLAGS_IGNORED}
S="${WORKDIR}"


src_prepare() { eapply_user; }
src_configure() { :; }
src_compile() { :; }

src_install() {
	exeinto /opt/${PN}
	doexe streaming_extractor_music

	dodir /opt/bin
	dosym ../${PN}/streaming_extractor_music /opt/bin/streaming_extractor_music || die
}
