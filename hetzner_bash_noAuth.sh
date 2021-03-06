#!/usr/bin/env bash

echo "=========== PIP TOOLS ================="
sudo apt-get update
sudo apt install build-essential vim git wget htop curl python3 python3-dev python3-venv python3-pip -y


echo "=========== Install SQUID ================="
cd /opt
wget https://github.com/Emilianocm23/ipv6/raw/main/squid_hetzner.deb
sudo dpkg -i ./squid_hetzner.deb


echo "=========== MAKE DIRS ================="
mkdir /var/spool/squid3
mkdir /etc/squid

echo "=========== Prepare Python ================="
wget https://raw.githubusercontent.com/Emilianocm23/ipv6/main/requirements.txt
pip3 install -r requirements.txt

echo "=========== Increase file limits ================="
echo "* - nofile 500000" >> /etc/security/limits.conf
wget -O ipv6.py "https://raw.githubusercontent.com/Emilianocm23/ipv6/main/ipv6_no_auth.py"

echo "=========== Done :) ================="
