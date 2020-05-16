#!/bin/bash

echo ""
echo "========================================"
echo "Installing Gnome"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed gtk2 gtk3 gnome-terminal eog evince

(
	cd $DIR
	mkdir -p $HOME/.themes
	mkdir -p $HOME/.local/share/icons
	ln -s -f -r $HOME/.local/share/icons $HOME/.icons

	tar -C $HOME/.themes -xf ./Arc-Black-Classic-3.36.tar.xz 
	tar -C $HOME/.local/share/icons -xf ./Arc-ICONS.tar.xz
	tar -C $HOME/.local/share/icons -xf ./oxy-neon.tar.gz

	mkdir -p $HOME/.config/gtk-3.0
	dconf load / < dconf.ini

	ln -s -f -r $DIR/gtk-3.0-settings.ini $HOME/.config/gtk-3.0/settings.ini
	ln -s -f -r $DIR/gtkrc-2.0 $HOME/.gtkrc-2.0
)
