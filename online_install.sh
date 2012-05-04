#!/bin/bash

# This script should be run directly from the online repository like this:
# install curl using the following command:
# sudo apt-get install curl
# now run the following command:
# curl -L https://bitbucket.org/Colozus/dotfiles/raw/master/online_install.sh | bash
#
(
  mkdir -p ~/.config
  cd ~/.config
  
  sudo apt-get install git

  bitbucket_root="git@bitbucket.org:Colozus"
  if [ "`whoami`" != "oz" ]; then
    bitbucket_root="https://bitbucket.org/Colozus"
  fi

  echo ""
  echo "========================================"
  echo "Cloning dotfiles"
  git clone $bitbucket_root/dotfiles

  echo "========================================"
  echo "setting up linux"
  (
    cd dotfiles
    ./install.sh
  )
)
