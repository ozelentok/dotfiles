#!/bin/bash

#=========================================
# Zsh Settings Configuration
echo ""
echo "=============================="
echo "Zsh Settings Configuration"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

if [ ! -d "$HOME/.zsh" ]; then
	mkdir $HOME/.zsh
fi
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/syntaxhl

ln -s $DIR/zshrc $HOME/.zshrc
ln -s $DIR/aliases.zsh $HOME/.zsh/aliases.zsh
ln -s $DIR/zspower.py $HOME/.zsh/zspower.py
echo "Zsh Settings Configuration"
sudo usermod -s $(which zsh) $USER
echo ""
echo "=============================="
echo "Installing patched ubuntu mono fonts"
git clone https://github.com/pdf/ubuntu-mono-powerline-ttf.git ~/.fonts/ubuntu-mono-powerline-ttf
fc-cache -vf
