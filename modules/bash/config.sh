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

# add custom functions
cat ./functions.sh >> ~/.bashrc

# add custom aliases
cat ./aliases.sh >> ~/.bash_aliases
