#!/usr/bin/env bash


cd /opt
wget https://github.com/Emilianocm23/ipv6/raw/main/squid_3.deb
sudo apt install ./squid_3.deb
chmod 777 /usr/local/squid/var/logs/
mkdir /var/spool/squid3
mkdir /etc/squid
wget https://raw.githubusercontent.com/Emilianocm23/ipv6/main/requirements.txt;
pip3 install -r requirements.txt;
echo "* - nofile 500000" >> /etc/security/limits.conf;
wget https://raw.githubusercontent.com/Emilianocm23/ipv6/main/ipv6.py;
