#!/usr/bin/env bash

echo "=========== Install SQUID ================="
cd /opt
wget https://github.com/Emilianocm23/ipv6/raw/main/squid_hetzner.deb
sudo dpkg -i ./squid_hetzner.deb

echo "=========== MAKE DIRS ================="
sudo mkdir -p /usr/local/squid/var/logs/
mkdir /var/spool/squid3
mkdir /etc/squid

echo "=========== Prepare Python ================="
wget https://raw.githubusercontent.com/Emilianocm23/ipv6/main/requirements.txt
pip3 install -r requirements.txt

echo "=========== Increase file limits ================="
echo "* - nofile 500000" >> /etc/security/limits.conf
wget https://raw.githubusercontent.com/Emilianocm23/ipv6/main/ipv6.py

echo "=========== Done :) ================="
