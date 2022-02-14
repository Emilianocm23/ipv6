#!/usr/bin/env bash

echo "=========== Install SQUID ================="
cd /opt
wget https://github.com/Emilianocm23/ipv6/raw/main/squid_no_arch.deb
sudo apt install ./squid_no_arch.deb

echo "=========== MAKE DIRS ================="
mkdir /var/spool/squid3
mkdir /etc/squid

echo "=========== Prepare Python ================="
wget https://raw.githubusercontent.com/Emilianocm23/ipv6/main/requirements.txt
pip3 install -r requirements.txt

echo "=========== Increase file limits ================="
echo "* - nofile 500000" >> /etc/security/limits.conf

echo "=========== Configure IPV6 from python file ================="
wget https://raw.githubusercontent.com/Emilianocm23/ipv6/main/ipv6.py
PYTHONPATH=/opt/v6proxies python3 ipv6.py --net_interface enp1s0 --pool_name squidv6 --number_ipv6 500 --unique_ip 1 --start_port 10000 --username lczzgw --password 3gRmJcE2Q

echo "=========== Add all IPS to server and allow connections ================="
bash /opt/add_ip_squidv6.sh
/usr/local/squid/sbin/squid -f /etc/squid/squid-squidv6.conf
sudo ufw disable

echo "=========== Done :) ================="
