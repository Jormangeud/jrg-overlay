EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit versionator distutils
#MY_TAG="7be914714750"
#MY_PN=${PN/-/_}
#MY_PKG="Mekk-${MY_PN}-${MY_TAG}"

#MY_PV=$(replace_all_version_separators '-')
DESCRIPTION="Helper scripts for Calibre ebook management"
HOMEPAGE="http://pypi.python.org/pypi/mekk.calibre/"
#SRC_URI="http://bitbucket.org/Mekk/${MY_PN}/get/${PV}.tar.bz2 -> ${P}.tar.bz2"
SRC_URI="https://pypi.python.org/packages/source/m/mekk.calibre/mekk.calibre-${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="chm djvu doc2rtf mso pdf"

DEPEND=">=dev-lang/python-2.6
		dev-python/lxml"
RDEPEND=">=app-text/calibre-0.7
		chm? ( app-text/archmage )
		djvu? ( app-text/djvu )
		doc2rtf? ( dev-python/ootools )
		mso? ( app-text/catdoc )
		pdf? ( app-text/poppler[utils] )
"
S="${WORKDIR}/mekk.calibre-${PV}"

src_install() {
	distutils_src_install
	dodoc README.txt
}
