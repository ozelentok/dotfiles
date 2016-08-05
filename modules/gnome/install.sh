#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Gnome"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -S gnome gnome-tweak-tool gnome-settings-daemon

(
	cd $DIR
	sudo gsettings set org.gnome.settings-daemon.plugins.cursor active false
	sudo gsettings set org.gnome.settings-daemon.plugins.keyboard active false
)
