# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A loudness scanner compilant with ITU-R BS.1770 and its flavors"
HOMEPAGE="http://pbelkner.de/projects/web/bs1770gain/"

SRC_URI="http://pbelkner.de/count/download.php?path=projects/files/bs1770gain/bs1770gain/${PV}&file=bs1770gain-${PV}.tar.gz -> bs1770gain-${PV}.tar.gz"

#MY_P=${PN}-${MY_PV}
#S=${WORKDIR}/${MY_P}

RDEPEND="media-video/ffmpeg[postproc]"
DEPEND="${RDEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

