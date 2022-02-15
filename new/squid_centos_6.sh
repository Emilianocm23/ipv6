#!/bin/bash

# ShadowSocks Installer for CREATEPROXY.com
# Email: info@createproxy.com

apt update
apt autoremove -y
modprobe tcp_bbr
echo "tcp_bbr" >> /etc/initramfs-tools/modules
update-initramfs -u -k $(uname -r)
sysctl -w net.ipv4.tcp_congestion_control=bbr
sysctl -w net.ipv4.tcp_fastopen=3
echo 'net.ipv4.tcp_congestion_control = bbr' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_fastopen = 3' >> /etc/sysctl.conf
apt install shadowsocks-libev rng-tools simple-obfs -y
systemctl enable shadowsocks-libev
cat <<EOF > /etc/shadowsocks-libev/config.json
{
    "server": [
        "0.0.0.0",
        "::0"
    ],
    "server_port": 3128,
    "password": "5qw5x",
    "timeout": 60,
    "method": "aes-256-cfb",
    "fast_open": true
}
EOF
reboot
