
#!/bin/bash

echo ""
echo "========================================"
echo "Installing mount-utils"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

(
	cd /mnt
	sudo mkdir sftp cifs
	sudo chown $USER:users /mnt/sftp /mnt/cifs

	cd $DIR
	sudo ln -s -f $DIR/wmount.sh /usr/local/bin/wmount
	sudo ln -s -f $DIR/wumount.sh /usr/local/bin/wumount
	sudo ln -s -f $DIR/sftpmount.sh /usr/local/bin/sftpmount
	sudo ln -s -f $DIR/sftpumount.sh /usr/local/bin/sftpumount
)
