#!/bin/bash

echo ""
echo "========================================"
echo "Installing X11"
echo "Configuring Keyboard & Monitor"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed xorg-server xorg-xinit xorg-xkill

(
	TODIR="/etc/X11/xorg.conf.d/"
	cd $DIR
	sudo mkdir -p $TODIR
	for confFile in *.conf; do
		sudo ln -s -f $DIR/$confFile $TODIR
	done
	ln -s -f $DIR/xinitrc $HOME/.xinitrc
)
