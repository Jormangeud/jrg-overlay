# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DEADBEEF_GUI="yes"
GITLAB_COMMIT="47bc3fe0fe151dfbb75f90f9e4d5e9a7affd280a"

inherit autotools deadbeef-plugins

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/zykure/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://gitlab.com/zykure/${PN}/repository/${GITLAB_COMMIT}/archive.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${GITLAB_COMMIT}-${GITLAB_COMMIT}"
fi

DESCRIPTION="DeaDBeeF filebrowser plugin"
HOMEPAGE="https://gitlab.com/zykure/deadbeef-fb"

LICENSE="GPL-2"

IUSE+=" debug"

RDEPEND+=" !media-plugins/deadbeef-librarybrowser:0"

DEPEND="${RDEPEND}"


src_prepare() {
	eapply "${FILESDIR}/${PN}-avoid-version.patch"

	eautoreconf

	default
}

src_configure() {
	econf --disable-static \
		$(use_enable debug) \
		$(use_enable gtk2) \
		$(use_enable gtk3)
}
