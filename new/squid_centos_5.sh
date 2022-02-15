wget https://raw.githubusercontent.com/zdenekslavik/CreateProxy/master/squid3-install.sh
bash squid3-install.sh
/usr/bin/htpasswd -b -c /etc/squid/passwd lodv 5qw5x
service squid restart
