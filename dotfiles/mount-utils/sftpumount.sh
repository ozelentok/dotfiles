#!/bin/bash

set -e

if [ "$#" -lt 1 ]; then
	echo "sftpumount - Unmount SFTP Share from /mnt/sftp"
	echo "Usage: sftpumount [HOST]"
	echo ""
	exit 1
fi
REMOTE_HOST=$1
fusermount -u /mnt/sftp/$REMOTE_HOST
rmdir /mnt/sftp/$REMOTE_HOST
echo "Share dismounted from /mnt/sftp/$REMOTE_HOST"
