# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Simple convenience library for handling properties and signals in C++11"
HOMEPAGE="https://launchpad.net/properties-cpp"
MY_TAG="14.10.20140730"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}+${MY_TAG}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
RESTRICT="mirror"

DEPEND="doc? ( app-doc/doxygen )
        test? ( dev-cpp/gtest
                dev-cpp/gmock )
        dev-libs/boost"

S="${WORKDIR}/${PN}-${PV}+${MY_TAG}"
MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {

	use doc || \
		sed -i 's:add_subdirectory(doc)::g' \
			-i "${S}/CMakeLists.txt"
	use test || \
		sed -i 's:add_subdirectory(tests)::g' \
			-i "${S}/CMakeLists.txt"
	cmake-utils_src_prepare
}
