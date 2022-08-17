#!/bin/sh
port=1080
passwd=lockey
path=lockey

# Download panindex
wget -q https://github.com/libsgh/PanIndex/releases/latest/download/PanIndex-linux-amd64.tar.gz -O panindex.tar.gz
tar -zxvf panindex.tar.gz
mv PanIndex-linux-amd64 /usr/local/bin/panindex
rm -f panindex.tar.gz & rm -f LICENSE
chmod +x /usr/local/bin/panindex

## Install brook
wget -q https://github.com/txthinking/brook/releases/latest/download/brook_linux_amd64 -O /usr/local/bin/brook
chmod +x /usr/local/bin/brook

## Start service
panindex &
/usr/bin/tor &
brook wsserver --listen :${port} --password ${passwd} --path ${path}
