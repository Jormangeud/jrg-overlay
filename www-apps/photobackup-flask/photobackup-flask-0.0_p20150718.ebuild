# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4} )

inherit webapp python-single-r1

TAG="612e928c80a8e5eac0960f299a470155c02fdcc7"
MY_PN="server-flask"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PhotoBackup/server-flask.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/PhotoBackup/server-flask/archive/${TAG}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_PN}-${TAG}
fi

DESCRIPTION="A simple PhotoBackup server, made with Flask"
HOMEPAGE="http://photobackup.github.io/"

LICENSE="GPL-3"
IUSE="+python_single_target_python3_3"

RDEPEND="
	>=dev-python/flask-0.8[${PYTHON_USEDEP}]
	dev-python/logbook[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

pkg_setup() {
	python-single-r1_pkg_setup
	webapp_pkg_setup
}

src_compile() {
	true
}

src_prepare() {
    python_fix_shebang .
}

src_install() {
	webapp_src_preinst
	insinto "${MY_HTDOCSDIR}"
	doins photobackup.py
	doins install.py
	doins -r templates

	webapp_serverowned "${MY_HTDOCSDIR}"/*
	webapp_src_install
	fperms ug=rwx,o=r photobackup.py install.py
}
