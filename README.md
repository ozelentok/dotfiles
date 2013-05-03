#Oz Elentok's Linux-Config

- Made For Ubuntu (12.10)
- Window Manager: i3wm
- Program Launcher: Kupfer/dmenu

##Installation Procedures

1. Run the following command:
	
  $ wget https://raw.github.com/ozelentok/dotfiles/master/online_install.sh -O /tmp/tempInstall.sh && bash /tmp/tempInstall.sh

##Set Up a Wallpaper

1. Rename the image you want to use as a wallpaper to 'wallpaper.png'
(if your image isn't a PNG, convert it to PNG using GIMP)

2. Copy it to ~/Pictures/

3. Reboot

##Qt-Config

Programs which use Qt will look horrible unless configured with qtconfig
Notes: qtconfig should be installed already by the script, if not installed run
the following command:

  $ sudo apt-get install qt4-qtconfig

1. Run qtconfig and the window 'Qt Configuration' will appear
	
  $ qtconfig

2. Under the 'Appearance' tab, at GUI Style, select 'GTK+'

##View CPU Temperatures

1. Install lm-sensors

  $ sudo apt-get install lm-sensors

2. Configure the sensors (follow the prompt instructions)

  $ sudo sensors-detect

3. To view your CPU temperatures, type the following command

  $ sensors

##Create special user for file sharing

1. Create the system user: 

  $ sudo useradd {username} -p {password} -g sambashare

2. Create the samba user:

  $ sudo smbpasswd -a {username}

3. Add the user to the /etc/samba/smbusers file:
  
  $ sudo su
  $ echo '{username} = "{username}"' > /etc/samba/smbusers

Note: when mounting partitions use the "sambashare" group as the mountpoint's group.

##Auto-mount partitions

1. Run the following command to get the UUID of the partitions:

  $ sudo blkid

2. Open the file /etc/fstab with any text editor (root privileges are required)

3. For each partition, add the following (single) line to the file:

UUID={uuid} /media/{mountname} {filesytem} rw,uid={username},gid=sambashare,umask=023 0 0

Notes:
{uuid} = The UUID of the partition
{mountname} = The name of the mount point
{filesystem} = The filesystem of the partiton

by setting the gid to "sambashare", the special samba user defined in the previous section can access shares on these partitions.

Example:
UUID=0001111100001100  /media/data ntfs, rw,uid=bob,gid=sambashare,umask=023 0 0
