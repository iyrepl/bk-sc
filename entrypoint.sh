#!/bin/sh

# Download and install brook
wget -q https://github.com/txthinking/brook/releases/latest/download/brook_linux_amd64 -O /usr/local/bin/brook
chmod +x /usr/local/bin/brook

# Run panindex & brook & nginx
/usr/local/nginx/sbin/nginx", "-g", "daemon off;" && /usr/local/bin/brook wsserver --listen :${PORT} --password ${passwd} 
#/usr/local/bin/panindex && /usr/local/bin/brook wsserver --listen :${PORT} --password ${passwd} && /usr/local/nginx/sbin/nginx", "-g", "daemon off;"
