#!/bin/bash

set -e

if [ "$#" -lt 4 ]; then
	echo "sftpmount - Mount SFTP Share on /mnt/sftp"
	echo "Usage: sftpmount host remote_dir local_dir_name user [optlist]"
	echo ""
	exit 1
fi
LOCAL_USER=$USER
LOCAL_GROUP=$(id -g -n $USER)
REMOTE_HOST=$1
REMOTE_PATH=$2
LOCAL_DIR_NAME=$3
REMOTE_USER=$4
mkdir -p /mnt/sftp/$REMOTE_HOST/$LOCAL_DIR_NAME
set +e
sshfs $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH \
/mnt/sftp/$REMOTE_HOST/$LOCAL_DIR_NAME ${@:5}

MOUNT_EXIT_CODE=$?
set -e
if [ $MOUNT_EXIT_CODE -ne 0 ]; then
	rmdir /mnt/sftp/$REMOTE_HOST/$LOCAL_DIR_NAME
	rmdir --ignore-fail-on-non-empty /mnt/sftp/$REMOTE_HOST
else
	echo "Share mounted on /mnt/sftp/$REMOTE_HOST/$LOCAL_DIR_NAME"
fi
