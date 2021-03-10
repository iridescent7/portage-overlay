# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev

DESCRIPTION=" A program to read and control device brightness"
HOMEPAGE="https://github.com/Hummer12007/brightnessctl"

RESTRICT="mirror"
SRC_URI="https://github.com/Hummer12007/brightnessctl/archive/${PV}.tar.gz -> brightnessctl-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="virtual/udev"

src_compile() {
	emake
}

src_install() {
	dobin brightnessctl
	udev_dorules 90-brightnessctl.rules
}

pkg_postinst() {
	udev_reload
}
