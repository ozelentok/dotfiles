#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Git"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
(
	cd $DIR
	ln -s $PWD/gitconfig $HOME/.gitconfig
	ln -s $PWD/gitignore_global $HOME/.gitignore_global
)
