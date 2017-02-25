#!/bin/bash

echo ""
echo "========================================"
echo "Installing GNU GLOBAL"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

(
	git clone "https://aur.archlinux.org/global.git" /tmp/global
	cd /tmp/global
	makepkg -Acs
	sudo pacman -U global*.pkg*
	sudo pip2 install Pygments

	ln -s $DIR/globalrc ~/.globalrc
	sudo sed -i '1s/python/python2/' /usr/share/gtags/script/pygments_parser.py
)
