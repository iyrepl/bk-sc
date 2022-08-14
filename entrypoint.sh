#!/bin/sh

# Download brook
#wget -q https://github.com/txthinking/brook/releases/latest/download/brook_linux_amd64 -O /usr/local/bin/brook
#chmod +x /usr/local/bin/brook

# Run brook & nginx & tor

URL="$(wget -qO- https://api.github.com/repos/txthinking/brook/releases/latest | grep -E "browser_download_url.*brook_linux_amd64" | cut -f4 -d\")" && \
wget -O /usr/bin/brook $URL && \
chmod +x /usr/bin/brook

brook wsserver --listen :1080 --path /iyreplsc233 --password iyreplsc233

/usr/local/nginx/sbin/nginx -g 'daemon off;'
