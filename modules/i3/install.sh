#!/bin/bash

echo ""
echo "========================================"
echo "Installing i3wm"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
(
	cd $DIR
	TODIR="$HOME/.i3/"
	mkdir -p $TODIR
	ln -s $PWD/config $TODIR
	ln -s $PWD/i3status.conf $TODIR 
	ln -s $PWD/i3-session $TODIR 
	mkdir -p "/usr/share/xsessions"
	ln -s $PWD/i3-session.desktop /usr/share/xsessions/
)
