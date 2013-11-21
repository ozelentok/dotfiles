#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

echo ""
echo "========================================"
echo "Configuring vim"
echo "========================================"

ln -sf $DIR/vimrc $HOME/.vimrc
git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
mkdir -p $HOME/.vim/colors
cp $DIR/colosus.vim $HOME/.vim/colors/colosus.vim
cp -r $DIR/mySnips $HOME/.vim/mySnips

vim +BundleInstall +qall
