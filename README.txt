Oz Elentok's Linux-Config
======================
This is a slimmed down, basic version of David Elentok Linux-Config
(https://bitbucket.org/3david/dotfiles)

To install run(install curl beforehand):
	
  $ curl -L https://bitbucket.org/ozelentok/dotfiles/raw/master/online_install.sh | bash


Wallpaper
=========
1. rename the image you want to use as a wallpaper to 'wallpaper.png'
(if your image isn't a PNG, convert it to PNG using GIMP)

2. copy it to ~/.config

3. reboot


Create special user for file sharing
====================================

1. create the system user: 

  $ sudo useradd <username> -p <password> -g users

2. create the samba user:

  $ sudo smbpasswd -a <username>

3. add the user to the /etc/samba/smbusers file:
  
  $ sudo su
  $ echo '<username> = "<username>"' > /etc/samba/smbusers

NOTE: when mounting partitions use the "users" group as the mountpoint's group.

Auto-mount partitions
=====================

1. Install the "Storage Device Manager":

  $ sudo apt-get install pysdm

2. Open it, and for each partition use these settings:

  nls=iso8859-8,umask=027,utf8,gid=users,uid=<username>
  
  uid will hold the user name:
  eg. uid=oz

  by setting the gid to "users", the special samba user defined in the previous section
  can access shares on these partitions. Also, by setting the "umask" to 027 that user
  will only have read-access.

