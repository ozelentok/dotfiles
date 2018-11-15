#!/bin/bash

set -e

if [ "$#" -lt 3 ]; then
	echo "wmount - Mount CIFS Shares on /mnt/cifs"
	echo "Usage: wmount HOST REMOTE_DIR USER [optlist]"
	echo ""
	exit 1
fi
LOCAL_USER=$USER
LOCAL_GROUP=$(id -g -n $USER)
REMOTE_HOST=$1
REMOTE_DIR=$2
REMOTE_USER=$3
sudo mkdir -p /mnt/cifs/$REMOTE_HOST/$REMOTE_DIR
set +e
sudo mount -t cifs //$REMOTE_HOST/$REMOTE_DIR \
/mnt/cifs/$REMOTE_HOST/$REMOTE_DIR -o user=$REMOTE_USER,\
rw,uid=$LOCAL_USER,gid=$LOCAL_GROUP,cache=strict,${@:4}

MOUNT_EXIT_CODE=$?
set -e
if [ $MOUNT_EXIT_CODE -ne 0 ]; then
	sudo rmdir /mnt/cifs/$REMOTE_HOST/$REMOTE_DIR
	sudo rmdir --ignore-fail-on-non-empty /mnt/cifs/$REMOTE_HOST
else
	echo "Share mounted on /mnt/cifs/$REMOTE_HOST/$REMOTE_DIR"
fi
