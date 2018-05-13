#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Gnome"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -S gnome-terminal gnome-themes-extra

(
	cd $DIR
	dconf load / < dconf.ini 
)
