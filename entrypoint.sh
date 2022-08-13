#!/bin/sh

# Download panindex
wget -q https://github.com/libsgh/PanIndex/releases/latest/download/PanIndex-linux-amd64.tar.gz -O panindex.tar.gz
tar -zxvf panindex.tar.gz
mv PanIndex-linux-amd64 /usr/local/bin/panindex
rm -f panindex.tar.gz & rm -f LICENSE
chmod +x /usr/local/bin/panindex

# Download brook
wget -q https://github.com/txthinking/brook/releases/latest/download/brook_linux_amd64 -O /usr/local/bin/brook
chmod +x /usr/local/bin/brook

# Run panindex & brook & nginx & tor

/usr/local/bin/panindex &

/usr/local/bin/brook wsserver --listen :1080 --path /lockey --password ${passwd} &

tor &

nginx -g 'daemon off;'
