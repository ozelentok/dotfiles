#!/usr/bin/env bash

if [ "$#" -lt 2 ]; then
  echo "sftpmount - Mount SFTP on /mnt/sftp"
  echo "Usage: sftpmount [HOST] [USER] [-u] [OPTIONS]"
  echo ""
  exit 1
fi

REMOTE_HOST=$1
REMOTE_USER=$2

MOUNTPOINT="/mnt/sftp/$REMOTE_HOST"

if [[ "$3" == "-u" ]]; then
  if mountpoint -q "$MOUNTPOINT"; then
    fusermount -u "$MOUNTPOINT" || exit 1
  fi
  if [ -d "$MOUNTPOINT" ]; then
    rmdir "$MOUNTPOINT" || exit 1
  else
    echo "$MOUNTPOINT is not mounted"; exit 2
  fi

  exit 0
fi

if mountpoint -q "$MOUNTPOINT"; then
  echo "$MOUNTPOINT is already mounted"; exit 1
fi

if ! mkdir -p "$MOUNTPOINT"; then
  echo "Failed to create directory $MOUNTPOINT"; exit 2
fi

# shellcheck disable=SC2199
if [[ "${@:3}" != *directport* ]]; then
  # shellcheck disable=SC2068
  sshfs "$REMOTE_USER@$REMOTE_HOST:/" "$MOUNTPOINT" ${@:3}
else
  # shellcheck disable=SC2068
  sshfs "$REMOTE_HOST:/" "$MOUNTPOINT" ${@:3}
fi

MOUNT_EXIT_CODE=$?
if [ $MOUNT_EXIT_CODE -ne 0 ]; then
  rmdir "$MOUNTPOINT"
  exit $MOUNT_EXIT_CODE
else
  echo "Mounted on $MOUNTPOINT"
fi
