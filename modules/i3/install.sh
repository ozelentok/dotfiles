#!/bin/bash

echo ""
echo "========================================"
echo "Installing i3wm"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed i3-wm i3lock i3status dmenu feh autocutsel

(
	TODIR="$HOME/.config/i3/"

	cd $DIR
	mkdir -p $TODIR
	ln -s -f -r $DIR/config $TODIR
	ln -s -f -r $DIR/i3status.conf $TODIR
	ln -s -f -r $DIR/i3-session $TODIR

	./alttab/install.sh
)
