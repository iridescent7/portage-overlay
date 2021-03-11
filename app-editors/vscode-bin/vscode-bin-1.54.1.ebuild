# Copyright 2020 Gianni Bombelli <bombo82@giannibombelli.it>
# Distributed under the terms of the GNU General Public License  as published by the Free Software Foundation;
# either version 2 of the License, or (at your option) any later version.

EAPI=7

inherit desktop eutils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft (binary version)"
HOMEPAGE="https://code.visualstudio.com"

SRC_URI="https://update.code.visualstudio.com/${PV}/linux-x64/stable -> ${PF}.tar.gz"
RESTRICT="mirror strip bindist"

LICENSE="MS-vscode"
SLOT="0"
KEYWORDS="-* ~amd64"

DEPEND="
	>=media-libs/libpng-1.2.46
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
	x11-libs/libXtst
	!app-editors/vscode
"

RDEPEND="
	${DEPEND}
	app-accessibility/at-spi2-atk
	>=net-print/cups-2.0.0
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/libsecret[crypt]
"

QA_PRESTRIPPED="*"
QA_PREBUILT="opt/${PN}/code"

S="${WORKDIR}"

src_install(){
	insinto "/opt/${PN}"
	doins -r *
	fperms +x "/opt/${PN}/bin/code"
	fperms +x "/opt/${PN}/code"
	dosym "../../opt/${PN}/bin/code" "usr/bin/code"

	newicon "resources/app/resources/linux/code.png" "${PN}.png"
	make_desktop_entry "${PN}" "Visual Studio Code" "${PN}" "Development;IDE"
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
