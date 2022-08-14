#!/bin/sh

# Download brook
#wget -q https://github.com/txthinking/brook/releases/latest/download/brook_linux_amd64 -O /usr/local/bin/brook
#chmod +x /usr/local/bin/brook

# Run brook & nginx & tor

./usr/local/bin/brook wsserver --listen :1080 --path /iyreplsc233 --password iyreplsc233 &

/usr/bin/tor &

/usr/local/nginx/sbin/nginx -g 'daemon off;'
