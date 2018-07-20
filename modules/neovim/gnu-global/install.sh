#!/bin/bash

echo ""
echo "========================================"
echo "Installing GNU GLOBAL"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -S autoconf automake make fakeroot

(
	cd $DIR/global
	makepkg -Acs
	sudo pacman -U global*.pkg*
	git clean -f
	sudo pip2 install Pygments

	ln -s -f $DIR/globalrc $HOME/.globalrc
	sudo sed -i '1s/python$/python2/' /usr/share/gtags/script/pygments_parser.py
	echo ""
	echo "Remember to set GTAGSLABEL=pygments in your shell startup file"
	echo " (The Zsh module already includes this configuration)"
)
