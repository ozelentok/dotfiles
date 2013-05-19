#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
ln -sf $DIR/vimrc $HOME/.vimrc
cp $DIR/obsidian.vim $HOME/.vim/colors/obsidian.vim
git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
vim +BundleInstall +qall
