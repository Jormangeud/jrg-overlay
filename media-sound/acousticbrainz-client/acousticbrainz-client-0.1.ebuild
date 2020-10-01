# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MTG/acousticbrainz-client.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/MTG/acousticbrainz-client/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Submission client for AcousticBrainz project."
HOMEPAGE="http://acousticbrainz.org https://github.com/MTG/acousticbrainz-client"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>dev-python/requests-2.4[${PYTHON_USEDEP}]
	|| ( media-sound/essentia-extractor media-sound/essentia )
"

python_configure_all() {
	sed -i -e 's|data_files|#data_files|' setup.py || die
}
