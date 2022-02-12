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
cd /opt/
python3.6 ipv6.py --net_interface enp1s0 --pool_name squidv6 --number_ipv6 500 --unique_ip 1 --start_port 10000 --username lczzgw --password 3gRmJcE2Q
bash /opt/add_ip_squidv6.sh
/usr/local/squid/sbin/squid -f /etc/squid/squid-squidv6.conf
sudo ufw disable
