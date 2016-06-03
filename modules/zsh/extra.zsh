alias pwf='sudo poweroff'
alias rbt='sudo reboot'
alias mtp-mount='simple-mtpfs /mnt/mtp'
alias mtp-umount='fusermount -u /mnt/mtp'
alias cpptags='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++'
alias psu='ps -lF --ppid 2 -p 2 --deselect'

rdp() {
	rdesktop $1 -g 1920x1060 -u $2 -z -m -x m -0
}

startinx() {
	export DISPLAY=:0
	$1
}

sftpmount() {
	sshfs $1@$2:$3 /mnt/sftp
}
