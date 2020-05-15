#!/bin/bash

echo ""
echo "=============================="
echo "Configuring font configuration"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

(
	cd $DIR
	mkdir -p $HOME/.config/fontconfig
	ln -s -f -r ./fonts.conf $HOME/.config/fontconfig
)
