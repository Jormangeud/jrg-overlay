# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1

DESCRIPTION="Helper scripts for Calibre ebook management"
HOMEPAGE="http://pypi.python.org/pypi/mekk.calibre/"
SRC_URI="https://pypi.python.org/packages/source/m/mekk.calibre/mekk.calibre-${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="chm djvu doc2rtf mso pdf"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}
	>=app-text/calibre-0.7
	chm? ( app-text/archmage )
	djvu? ( app-text/djvu )
	doc2rtf? ( dev-python/ootools )
	mso? ( app-text/catdoc )
	pdf? ( app-text/poppler[utils] )
"

S="${WORKDIR}/mekk.calibre-${PV}"

src_prepare() {

	cat > "${S}"/src/mekk/__init__.py <<-EOF || die "namespace declaring"
	__import__('pkg_resources').declare_namespace(__name__)
	EOF
	default
}

#python_install() {
#	python_foreach_impl python_domodule ${MODNAME}
#
#	distutils-r1_python_install --single-version-externally-managed
#	find "${ED}" -name '*.pth' -delete || die "pth deleting"
#	dodoc README.txt
#}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
