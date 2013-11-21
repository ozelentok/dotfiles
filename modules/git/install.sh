#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Git"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
ln -sf "$DIR/gitconfig" $HOME/.gitconfig
ln -sf "$DIR/gitignore_global" $HOME/.gitignore_global
