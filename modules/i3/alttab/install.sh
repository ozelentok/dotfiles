#!/bin/bash

echo ""
echo "========================================"
echo "Installing AltTab"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed autoconf automake make fakeroot

(
	cd $DIR
	makepkg -fci
	rm -rf alttab
)
