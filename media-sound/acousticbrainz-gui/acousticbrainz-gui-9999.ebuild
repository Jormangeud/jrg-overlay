# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{6..14} )
DISTUTILS_USE_PEP517=setuptools

inherit cmake

GIT_ACCOUNT="MTG"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${GIT_ACCOUNT}/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/${GIT_ACCOUNT}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="This client lets you submit your own audio features to the AcousticBrainz project."
HOMEPAGE="http://acousticbrainz.org https://github.com/${GIT_ACCOUNT}/${PN}"

LICENSE="GPLv2"
SLOT="0"
IUSE=""

DEPEND="dev-qt/qtgui:5"
RDEPEND="${DEPEND}
	|| ( media-sound/essentia-extractor media-sound/essentia )
"
