#!/bin/bash
#Silent install netdata for Ubuntu targets
#Bucharest March 2018 A.D.
#Version 0.0.1
#Usage run as sudo
sudo apt-get update
echo 'System updated ...'
sudo apt-get install zlib1g-dev uuid-dev libmnl-dev gcc make autoconf autoconf-archive autogen automake pkg-config curl
echo 'Development libs installed ...'
sudo apt-get install python python-yaml python-mysqldb python-psycopg2 nodejs lm-sensors netcat
echo 'NetData dependencies added ...'
git clone https://github.com/firehol/netdata.git --depth=1 ~/netdata
echo 'Netdata repo installer cloned ...'
cd ~/netdata
sudo ./netdata-installer.sh
set prompt ":|#|\\\$"
interact -o -nobuffer -re $prompt return
send "ENTER"
echo 'NetData installation succesfully ...'

ufw status | grep -qw active
if [ $? == "1" ]; then
	echo 'ufw firewall detected ...  '
	echo 'Opening port 19999 in local firewall ...' 
	sudo ufw allow 19999/tcp
fi
SERV='/sbin/service iptables status'
EXPR='Firewall is stopped.'
if [ "$SERV" = "$EXPR" ]; then
	echo 'iptables firewall detected ...'
	echo 'Opening port 19999 in local firewall ...' 
        iptables -I INPUT -p tcp --dport 19999 -j ACCEPT
fi


