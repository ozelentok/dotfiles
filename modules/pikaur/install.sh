#!/bin/bash

echo ""
echo "========================================"
echo "Installing pikaur - AUR helper"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed base-devel git
cd /tmp
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsci
