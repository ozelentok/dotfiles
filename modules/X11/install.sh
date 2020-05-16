#!/bin/bash

echo ""
echo "========================================"
echo "Installing X11"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed xorg-server xorg-xinit xorg-xkill xorg-xhost xorg-xev

cd $DIR
XORG_CONF_DIR=/etc/X11/xorg.conf.d
sudo mkdir -p $XORG_CONF_DIR
sudo ln -s -f -r ./00-keyboard.conf $XORG_CONF_DIR/00-keyboard.conf
ln -s -f -r ./xinitrc $HOME/.xinitrc
ln -s -f -r ./Xresources $HOME/.Xresources
