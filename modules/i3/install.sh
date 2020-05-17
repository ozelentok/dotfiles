#!/bin/bash

echo ""
echo "========================================"
echo "Installing i3wm"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed i3-wm i3lock py3status dmenu feh autocutsel python-pytz python-tzlocal xorg-xset

(
	TODIR="$HOME/.config/i3"

	cd $DIR
	mkdir -p $TODIR
	ln -s -f -r ./i3.config $TODIR/config
	ln -s -f -r ./i3-session $TODIR/
	ln -s -f -r ./i3status.conf $TODIR/
	ln -s -f -r ./py3status $TODIR/

	./alttab/install.sh
	./xkb-switch/install.sh
)
