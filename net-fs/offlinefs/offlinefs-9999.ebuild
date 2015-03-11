# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
#ESVN_REPO_URI="http://offlinefs.svn.sourceforge.net/svnroot/offlinefs/ofs/trunk"
ESVN_REPO_URI="svn://svn.code.sf.net/p/offlinefs/code/ofs/trunk"
ESVN_PROJECT="offlinefs"

inherit subversion autotools

DESCRIPTION="A FUSE-based offline filesystem"
HOMEPAGE="http://offlinefs.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="
      >=dev-libs/confuse-2.6
      sys-apps/attr
      sys-apps/dbus
      =sys-fs/fuse-2*
      doc? (
          app-doc/doxygen
          media-gfx/graphviz
     )"

RDEPEND="${DEPEND}"

src_prepare() {
      eautoreconf
}
