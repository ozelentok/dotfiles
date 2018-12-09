#!/bin/bash

echo ""
echo "========================================"
echo "Installing Double Commander"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TODIR="$HOME/.config/doublecmd"

sudo pacman -Syu --needed doublecmd-gtk2

(
	cd $DIR
	mkdir -p $TODIR
	cp $DIR/doublecmd.xml $TODIR/doublecmd.xml
)
