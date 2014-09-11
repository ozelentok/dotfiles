#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Samba"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TODIR="/etc/samba"
(
	cd $DIR
	mkdir -p $TODIR
	cp smb.conf $TODIR
)

