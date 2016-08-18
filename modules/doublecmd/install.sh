#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Double Commander"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TODIR="$HOME/.config/doublecmd"

sudo pacman -S doublecmd-gtk2

(
	cd $DIR
	sudo mkdir -p $TODIR
	cp $DIR/doublecmd.xml $TODIR/doublecmd.xml
)
