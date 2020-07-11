#!/bin/bash

echo ""
echo "========================================"
echo "Installing GNU GLOBAL"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed autoconf automake make fakeroot
pip install --user -U Pygments

cp $DIR/PKGBUILD /tmp
cd /tmp
makepkg -fsci
ln -s -f -r $DIR/globalrc $HOME/.globalrc
