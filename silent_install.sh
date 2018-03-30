#!/bin/bash
#Silent install netdata for Ubuntu targets
#Bucharest March 2018 A.D.
#Version 0.0.1
#Usage run as sudo
sudo apt-get update
echo 'System updated ...\n'
sudo apt-get install zlib1g-dev uuid-dev libmnl-dev gcc make autoconf autoconf-archive autogen automake pkg-config curl
echo 'Development libs installed ...\n'
sudo apt-get install python python-yaml python-mysqldb python-psycopg2 nodejs lm-sensors netcat
echo 'NetData dependencies added ...\n'
git clone https://github.com/firehol/netdata.git --depth=1 ~/netdata
echo 'Netdata repo installer cloned ...\n'
cd ~/netdata
sudo ./netdata-installer.sh
set prompt ":|#|\\\$"
interact -o -nobuffer -re $prompt return
send "ENTER"
echo 'NetData installation succesfully ...\n'

sudo ufw status | grep -qw active
if [$? == 1]; then
	echo 'ufw firewall detected ... \n '
	echo 'Open port in local firewall ... \n' 
#	sudo ufw allow 19999/tcp
fi

