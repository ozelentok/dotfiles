#!/bin/bash

echo ""
echo "========================================"
echo "Configuring X11"
echo "Keyboard and Monitors"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -S xorg-server xorg-xinit xorg-xkill

(
	TODIR="/etc/X11/xorg.conf.d/"
	cd $DIR
	sudo mkdir -p $TODIR
	for confFile in *.conf; do
		sudo cp $confFile $TODIR
	done
	cp xinitrc $HOME/.xinitrc
)
