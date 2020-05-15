#!/bin/bash

echo ""
echo "=============================="
echo "Installing Nerd Fonts"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

cp $DIR/PKGBUILD /tmp
cd /tmp
makepkg -fsci
