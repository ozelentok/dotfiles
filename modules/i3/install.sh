#!/bin/bash

echo ""
echo "========================================"
echo "Installing i3wm"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TODIR="$HOME/.i3/"
mkdir -p $TODIR
ln -sf "$DIR/config" $TODIR
ln -sf "$DIR/i3status.conf" $TODIR 
ln -sf "$DIR/i3-session" $TODIR 

sudo sh -c "cat $DIR/i3-session.desktop | sed \"s#/home/oz#$HOME#\" > /usr/share/xsessions/i3-session.desktop"
