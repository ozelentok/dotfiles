#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Gnome"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

(
	cd $DIR
	sudo pacman -Sy gnome
	gsettings set org.gnome.settings-daemon.plugins.cursor active false
	gsettings set org.gnome.settings-daemon.plugins.keyboard active false 
)
