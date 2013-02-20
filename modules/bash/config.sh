#!/bin/bash

#=========================================
# Bash Settings Configuration
echo ""
echo "=============================="
echo "Bash Settings Configuration"

# set auto completion to be case-insensitive
echo "set completion-ignore-case on" | sudo tee -a /etc/inputrc

# set terminal colors to 256
echo "export TERM=xterm-256color" | sudo tee -a ~/.bashrc

# script dir
DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
# add custom functions
cat $DIR/functions.sh >> ~/.bashrc

# add custom aliases
cat $DIR/aliases.sh >> ~/.bash_aliases
