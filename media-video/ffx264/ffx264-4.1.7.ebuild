# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Script to encode video files to H.264/AVC video using the FFmpeg encoder"
HOMEPAGE="https://ffx264.teambelgium.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-video/ffmpeg[fdk,fontconfig,libass,mp3,opus,vorbis,x264,zimg]"
DEPEND=""

src_compile() {
	:
}

src_install() {
	emake install PREFIX="${ED}usr"
}