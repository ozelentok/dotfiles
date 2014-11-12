#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Samba"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TODIR="/etc/samba"
(
	sudo cd $DIR
	sudo mkdir -p $TODIR
	sudo cp smb.conf $TODIR
)

