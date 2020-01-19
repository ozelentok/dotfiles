#!/bin/bash

echo ""
echo "========================================"
echo "Installing GNU GLOBAL"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed autoconf automake make fakeroot

(
	cd $DIR/global
	makepkg -fci
	git clean -f
	pip install --user -U Pygments

	ln -s -f -r $DIR/globalrc $HOME/.globalrc
	echo ""
	echo "Remember to set GTAGSLABEL=pygments in your shell startup file"
	echo " (The Zsh module already includes this configuration)"
)
