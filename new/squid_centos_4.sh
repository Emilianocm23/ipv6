#!/bin/sh
array=(1 2 3 4 5 6 7 8 9 0 a b c d e f)
install_3proxy() {
	URL="https://github.com/z3APA3A/3proxy/archive/0.8.13.tar.gz"
    wget -qO- $URL | bsdtar -xvf-
    cd 3proxy-0.8.13
    make -f Makefile.Linux
    mkdir -p /usr/local/etc/3proxy/{bin,logs,stat}
    cp src/3proxy /usr/local/etc/3proxy/bin/
    cp ./scripts/rc.d/proxy.sh /etc/init.d/3proxy
    chmod +x /etc/init.d/3proxy
    chkconfig 3proxy on
    cd $WORKDIR
}

gen_3proxy() {
    cat <<EOF
#This file was automatically generated by CreateProxy.com	
daemon
log /var/log/3proxy/3proxy.log D
nscache 65536

users "lodv:CL:5qw5x"

auth iponly
allow * 188.165.205.32,46.105.101.74,144.217.64.10,158.69.126.183,144.217.183.123,187.190.160.39
deny * *
socks -a -p3128
flush

auth iponly
allow * 188.165.205.32,46.105.101.74,144.217.64.10,158.69.126.183,144.217.183.123,187.190.160.39
deny * *
proxy -a -p3129
flush

auth strong
allow lodv
socks -a -p3130
flush

auth strong
allow lodv
proxy -a -p3131
flush
EOF
}

gen_iptables() {
cat <<EOF
iptables -I INPUT -p tcp --dport 3128  -m state --state NEW -j ACCEPT
iptables -I INPUT -p tcp --dport 3129  -m state --state NEW -j ACCEPT
iptables -I INPUT -p tcp --dport 3130  -m state --state NEW -j ACCEPT
iptables -I INPUT -p tcp --dport 3131  -m state --state NEW -j ACCEPT
EOF
}

yum -y install gcc net-tools bsdtar zip >/dev/null
install_3proxy

echo "working folder = /home/proxy-installer"
WORKDIR="/home/proxy-installer"
WORKDATA="${WORKDIR}/data.txt"
mkdir $WORKDIR && cd $_

gen_iptables >$WORKDIR/boot_iptables.sh
chmod +x boot_*.sh /etc/rc.local

gen_3proxy >/usr/local/etc/3proxy/3proxy.cfg

cat >>/etc/rc.local <<EOF
bash /home/proxy-installer/boot_iptables.sh
bash /home/proxy-installer/boot_ifconfig.sh
ulimit -n 64000
systemctl start 3proxy.service
EOF

bash /etc/rc.local


sudo groupadd --gid 65535 createproxy
sudo useradd -u 65535 --gid 65535 createproxy

mkdir /var/log/3proxy

echo "* hard nofile 64000" >> /etc/security/limits.conf
echo "* soft nofile 64000" >> /etc/security/limits.conf
echo "root hard nofile 64000" >> /etc/security/limits.conf
echo "root soft nofile 64000" >> /etc/security/limits.conf
echo "createproxy hard nofile 64000" >> /etc/security/limits.conf
echo "createproxy soft nofile 64000" >> /etc/security/limits.conf
echo "* hard nproc 64000" >> /etc/security/limits.conf
echo "* soft nproc 64000" >> /etc/security/limits.conf
echo "createproxy hard nproc 64000" >> /etc/security/limits.conf
echo "createproxy soft nproc 64000" >> /etc/security/limits.conf
echo "root hard nproc 64000" >> /etc/security/limits.conf
echo "root soft nproc 64000" >> /etc/security/limits.conf
sysctl -w fs.file-max=99999
sysctl -p 
sudo systemctl disable firewalld
sudo systemctl mask --now firewalld
reboot
