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
chsh -s $(which zsh)
