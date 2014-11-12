#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Gnome"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

(
	cd $DIR
	sudo pacman -Sy gnome gnome-tweak-tool
	sudo gsettings set org.gnome.settings-daemon.plugins.cursor active false
	sudo gsettings set org.gnome.settings-daemon.plugins.keyboard active false 
)
