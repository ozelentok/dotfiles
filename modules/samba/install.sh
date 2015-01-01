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
	sudo sh -c "sed -e \"s/HOST_NAME/$HOST/\" smb.conf > $TODIR"
)

