#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Qt Style"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed qt5-styleplugins

(
	mkdir -p "$HOME/.config"
	cp $DIR/Trolltech.conf $HOME/.config/Trolltech.conf
)
