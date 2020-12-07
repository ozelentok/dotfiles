#!/bin/bash

echo ""
echo "========================================"
echo "Installing mpv"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed mpv

(
	cd $DIR
	mkdir -p $HOME/.config/mpv
	ln -s -f -r $DIR/mpv.conf $HOME/.config/mpv/mpv.conf
)
