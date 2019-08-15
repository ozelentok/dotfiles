#!/bin/bash

echo ""
echo "========================================"
echo "Installing Git"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed git

(
	cd $DIR
	cp $DIR/gitconfig $HOME/.gitconfig
	ln -s -f -r $DIR/gitignore_global $HOME/.gitignore_global
)
