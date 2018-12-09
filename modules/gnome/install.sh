#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Gnome"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed gnome-terminal gnome-themes-extra eog evince

(
	cd $DIR
	dconf load / < dconf.ini
)
