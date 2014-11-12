#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Krusader"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TODIR="$HOME/.kde4/share/config"
sudo mkdir -p $TODIR
sudo cp "$DIR/krusaderrc" $TODIR

