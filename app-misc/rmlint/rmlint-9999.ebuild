# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils git-2 prefix

DESCRIPTION="Tool to remove duplicates and other lint, being much faster than fdupes"
EGIT_REPO_URI="git://github.com/sahib/rmlint.git"
SRC_URI=""
HOMEPAGE="https://github.com/sahib/rmlint"

RDEPEND="sys-libs/glibc"
DEPEND="${RDEPEND}"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~x86 ~amd64"
