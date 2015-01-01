#!/bin/bash

echo ""
echo "========================================"
echo "Configuring vsftpd"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TODIR="/etc/vsftpd"
echo "Enter FTP Username: "
read ftp_user
(
	cd $DIR
	sudo sh -c "sed -e \"s/FTP_USER/$ftp_user/\" vsftpd.conf > /etc/vsftpd.conf"
	sudo mkdir -p $TODIR
	sudo mkdir -p /srv/ftp
	sudo sh -c "echo $ftp_user > $TODIR/user_list"
)

