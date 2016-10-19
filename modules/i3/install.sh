#!/bin/bash

echo ""
echo "========================================"
echo "Installing i3wm"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -S i3-wm i3lock i3status dmenu feh

(
	cd $DIR
	TODIR="$HOME/.i3/"
	mkdir -p $TODIR
	ln -s $DIR/config $TODIR
	ln -s $DIR/i3status.conf $TODIR 
	ln -s $DIR/i3-session $TODIR 
	sudo mkdir -p "/usr/share/xsessions"
	sudo ln -s $DIR/i3-session.desktop /usr/share/xsessions/
)
