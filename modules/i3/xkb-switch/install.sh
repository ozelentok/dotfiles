#!/bin/bash

echo ""
echo "========================================"
echo "Installing xkb-switch"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed autoconf automake make cmake fakeroot
cp $DIR/PKGBUILD /tmp
cd /tmp
makepkg -fci
