# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND=2

inherit eutils python

DESCRIPTION="Finnish wordform patterns for malaga"
HOMEPAGE="http://voikko.sf.net/"
SRC_URI="mirror://sourceforge/voikko/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE_VOIKKO_VOCABULARY="
	extra_atk
	extra_linux
	extra_po
	extra_science
	style_dialect
	style_foreign
	style_foreignloan
	+style_inappropriate
	style_incorrect
	+style_international
	+style_old
	usage_education
	usage_it
	usage_medicine
	usage_orgname
	usage_science
"

IUSE="${IUSE_VOIKKO_VOCABULARY} doc"

DEPEND=">=sci-misc/malaga-7.8"
RDEPEND=">=sci-misc/malaga-7.8"

#style=dialect,foreign,incorrect old international foreignloan inappropriate --style=style1,style
#usage flags: it medicine science education orgname --extra-usage=usage1,usage2,...
#extra vocabulary: atk-lyhenteet linux-distributions po-oikoluku science-misc

src_compile() {
	local description
	description="style:"
	local style_opts
	for i in dialect foreignloan foreign inappropriate incorrect international old; do
		if use style_$i; then
			style_opts="${style_opts},$i"
			description="${description} $i"
		fi
	done
	local usage_opts
	description="${description} | usage:"
	for i in education it medicine orgname science; do
		if use usage_$i; then
			usage_opts="${usage_opts},$i"
			description="${description} $i"
		fi
	done
	local extra_opts
	description="${description} | extra:"
	if use extra_atk; then
		extra_opts="${extra_opts} vocabulary/erikoisalat/atk-lyhenteet.lex"
		description="${description} atk"
	fi
	if use extra_linux; then
		extra_opts="${extra_opts} vocabulary/erikoisalat/linux-distributions.lex"
		description="${description} linux"
	fi
	if use extra_po; then
		extra_opts="${extra_opts} vocabulary/erikoisalat/po-oikoluku.lex"
		description="${description} po"
	fi
	if use extra_science; then
		extra_opts="${extra_opts} vocabulary/erikoisalat/science-misc.lex"
		description="${description} science"
	fi

	emake \
		VOIKKO_VARIANT="gentoo" \
		VOIKKO_DESCRIPTION="suomi ($description)" \
		GENLEX_OPTS="--extra-usage=${usage_opts} --style=${style_opts}" \
		EXTRA_LEX="${extra_opts}" \
		PYTHON="python2" \
		voikko
}

src_install() {
	emake DESTDIR="${D}"/usr/lib/voikko/ voikko-install
	dodoc ChangeLog README.fi README CONTRIBUTORS
}
