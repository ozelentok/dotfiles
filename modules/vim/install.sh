#!/bin/bash

echo ""
echo "========================================"
echo "Configuring vim"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -S gvim

#For YouCompleteMe Support
sudo pacman -S cmake clang

(
	cd $DIR
	ln -s $PWD/vimrc $HOME/.vimrc
	git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
	mkdir -p $HOME/.vim/colors
	cp colosus.vim $HOME/.vim/colors/colosus.vim
	cp ycm_extra_conf.py $HOME/.vim/ycm_extra_conf.py
	vim +BundleInstall +qall
	cd ~/.vim/bundle/YouCompleteMe
	./install.py --clang-completer --system-libclang --tern-completer
)
