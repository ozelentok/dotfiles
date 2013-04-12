#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Git"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

ln -sf "$DIR/.gitconfig" ~/.gitconfig
ln -sf "$DIR/.gitignore_global" ~/.gitignore_global
