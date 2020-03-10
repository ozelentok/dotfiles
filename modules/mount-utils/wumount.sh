#!/bin/bash

set -e

if [ "$#" -lt 2 ]; then
	echo "wumount - Unmount CIFS Share from /mnt/cifs"
	echo "Usage: wumount [HOST] [SHARE]"
	echo ""
	exit 1
fi
REMOTE_HOST=$1
REMOTE_SHARE=$2
sudo umount /mnt/cifs/$REMOTE_HOST/$REMOTE_SHARE
rmdir /mnt/cifs/$REMOTE_HOST/$REMOTE_SHARE
rmdir --ignore-fail-on-non-empty /mnt/cifs/$REMOTE_HOST
echo "Share dismounted from /mnt/cifs/$REMOTE_HOST/$REMOTE_SHARE"
