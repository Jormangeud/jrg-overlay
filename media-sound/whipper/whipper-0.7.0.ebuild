# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

GIT_ACCOUNT="JoeLametta"

inherit distutils-r1 versionator toolchain-funcs


if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${GIT_ACCOUNT}/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/${GIT_ACCOUNT}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

HOMEPAGE="https://github.com/JoeLametta/whipper"
DESCRIPTION="Python CD-DA ripper preferring accuracy over speed (FORKED from morituri)"
LICENSE="GPL-3"

SLOT="0"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	media-libs/libsndfile
"
IUSE="cddb"

# forcing dev-lib/libcdio* to 0.94, as 2.0.0 needs pycdio-2.0.0
RDEPEND="${DEPEND}
	app-cdr/cdrdao
	|| ( (
		=dev-libs/libcdio-0.94*
		=dev-libs/libcdio-paranoia-0.94*
		>=dev-python/pycdio-0.20[${PYTHON_USEDEP}] <dev-python/pycdio-1[${PYTHON_USEDEP}]
		) (
		=dev-libs/libcdio-2.0*
		=dev-libs/libcdio-paranoia-2.0*
		=dev-python/pycdio-2.0*[${PYTHON_USEDEP}]
		)
	)
	dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/python-musicbrainz-ngs[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	media-libs/flac
	media-libs/libcddb
	media-libs/mutagen[${PYTHON_USEDEP}]
	media-sound/sox
	cddb? ( dev-python/cddb-py[${PYTHON_USEDEP}] )
"

python_prepare_all() {
	sed -i -r -e '/^(C|LD)FLAGS *= */ s| = | \+= |' src/config.mk || die
	sed -i -e 's/cd-paranoia/cdparanoia/g' whipper/program/cdparanoia.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	pushd "src"
	emake CC="$(tc-getCC)"
	popd

	distutils-r1_python_compile_all
}

python_install_all() {
	dobin "src/accuraterip-checksum"

	distutils-r1_python_install_all
}
