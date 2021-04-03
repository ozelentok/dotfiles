#!/bin/bash

echo ""
echo "========================================"
echo "Installing smplayer"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed smplayer

(
	cd $DIR
	mkdir -p $HOME/.config/smplayer
	cp $DIR/smplayer.ini $HOME/.config/smplayer/smplayer.ini
)
