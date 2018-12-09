#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Git"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed git

(
	cd $DIR
	cp $DIR/gitconfig $HOME/.gitconfig
	ln -s $DIR/gitignore_global $HOME/.gitignore_global
)
