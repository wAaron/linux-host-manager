#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install lnmp"
    exit 1
fi


 fdisk  -l  |  grep  "/dev/"  |  grep  "bytes"  |  awk  -F  ":"   '{print  $1}'  |   awk   '{print  $2}'  |  sort   >   /tmp/.disk.list

NUM=`wc  -l    /tmp/.disk.list  |  awk   '{print  $1}'`

DISK_NAME=`sed  -n  ''$NUM',1p'  /tmp/.disk.list`

count=`fdisk  -l  |  grep  $DISK_NAME\1  |  wc  -l`
zero=0

if  [  $count -eq  $zero  ]
then
fdisk $DISK_NAME  << EOF
n
p
1


wq
EOF
else
exit   1
fi

mkfs.ext4   $DISK_NAME\1

if [ -e /data ]
then
	exit  1;
else
	mkdir /data;
fi

echo  $DISK_NAME\1               /data                   ext4          defaults        1 2  >> /etc/fstab

mount -a

echo   "/data"   >    /tmp/.mount.list
