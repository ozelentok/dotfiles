#!/bin/bash

echo ""
echo "========================================"
echo "Installing Gnome"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed gtk2 gtk3 gnome-terminal gnome-themes-extra eog evince

(
	cd $DIR
	dconf load / < dconf.ini

	mkdir -p $HOME/.config/gtk-3.0
	ln -s -f -r $DIR/gtk-3.0-settings.ini $HOME/.config/gtk-3.0/settings.ini
	ln -s -f -r $DIR/gtkrc-2.0 $HOME/.gtkrc-2.0
)
