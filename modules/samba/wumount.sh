#!/bin/bash

set -e

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
	echo "wumount - Unmount CIFS Shares from /mnt/cifs"
	echo "Usage: wumount [HOST] [REMOTE DIR]"
	echo ""
	exit 1
fi
REMOTE_HOST=$1
REMOTE_DIR=$2
sudo umount /mnt/cifs/$REMOTE_HOST/$REMOTE_DIR
sudo rmdir /mnt/cifs/$REMOTE_HOST/$REMOTE_DIR
sudo rmdir --ignore-fail-on-non-empty /mnt/cifs/$REMOTE_HOST
echo "Share dismounted from /mnt/cifs/$REMOTE_HOST/$REMOTE_DIR"
