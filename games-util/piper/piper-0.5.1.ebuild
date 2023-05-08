# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit meson python-r1


if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/libratbag/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/libratbag/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Library to configure gaming mice"
HOMEPAGE="https://github.com/libratbag/piper"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}
	dev-python/python-evdev[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=dev-libs/libratbag-0.14
"

DEPEND="${RDEPEND}"

#PATCHES=( ${FILESDIR}/python3-config.patch )
