# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISTUTILS_OPTIONAL=1
PYTHON_COMPAT=( python3_{6..11} )


inherit multilib toolchain-funcs eutils python-single-r1 scons-utils gnome2-utils

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sahib/rmlint.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/sahib/rmlint/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Utility to find and remove space waste and broken things on filesystems"
HOMEPAGE="https://github.com/sahib/rmlint/ http://rmlint.readthedocs.org/"

X86_CPU_FEATURES=( cpu_flags_x86_sse4_2 )
IUSE="doc gui nls ${X86_CPU_FEATURES[@]}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	sys-libs/glibc
	>=dev-libs/glib-2.32
	dev-libs/json-glib
	sys-apps/util-linux
	dev-libs/elfutils
	gui? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			dev-python/pygobject:3[${PYTHON_USEDEP}]
		')
		gnome-base/librsvg
		x11-libs/gtk+:3
		x11-libs/gtksourceview:3.0
	)
"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
        doc? ( dev-python/sphinx )"

REQUIRED_USE="gui? ( ${PYTHON_REQUIRED_USE} )"

SLOT="0"
LICENSE="GPL-3"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {

	# Prevent installing /usr/share/glib-2.0/schemas/gschemas.compiled, gnome2-utils updates it
	eapply "${FILESDIR}/${PN}-gui-dont-compile-schemas.patch"

	if ! use doc ; then
		sed -i -e "/SConscript('docs\/SConscript')/d" SConstruct || die "couldn't disable docs"
	fi
	if ! use nls; then
		sed -i -e "/SConscript('po\/SConscript')/d" SConstruct || die "couldn't disable nls"
	fi
	if ! use gui; then
		sed -i -e "/SConscript('gui\/SConscript')/d" SConstruct || die "couldn't disable gui"
	fi
	if ! use cpu_flags_x86_sse4_2; then
		sed -i -e "s/conf.env.Append(CCFLAGS=['-msse4.2'])/pass/" SConstruct || die "couldn't disable sse4.2"
	fi
	default
}

src_compile() {
	myconf=$(use_with nls gettext)
	escons CC="$(tc-getCC)" --prefix=${D}/usr --actual-prefix=/usr --libdir=/usr/$(get_libdir) ${myconf}
}

src_install() {
	escons --prefix=${D}/usr --actual-prefix=/usr --libdir=/usr/$(get_libdir) install
	if use gui; then
		python_foreach_impl python_newscript gui/shredder/__main__.py shredder
	fi
}

pkg_preinst() {
	if use gui; then
		gnome2_schemas_savelist
	fi
}

pkg_postinst() {
	if use gui ; then
	    gnome2_icon_cache_update
	    gnome2_schemas_update
	fi
}

pkg_postrm() {
	if use gui ; then
	    gnome2_icon_cache_update
	    gnome2_schemas_update
	fi
}
