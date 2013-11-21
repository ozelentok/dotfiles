#!/bin/bash

echo ""
echo "========================================"
echo "Configuring X11"
echo "Keyboard and Monitors"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TODIR="/etc/X11/xorg.conf.d/"
mkdir -p $TODIR
for confFile in "$DIR"*.conf; do
	cp $confFile $TODIR
done

