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
	dconf load / < dconf.ini 

	# no longer needed on new versions
	#sudo gsettings set org.gnome.settings-daemon.plugins.cursor active false
	#sudo gsettings set org.gnome.settings-daemon.plugins.keyboard active false
)
