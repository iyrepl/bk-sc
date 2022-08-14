URL="$(wget -qO- https://api.github.com/repos/txthinking/brook/releases/latest | grep -E "browser_download_url.*brook_linux_amd64" | cut -f4 -d\")" && \
    wget -O /usr/bin/brook $URL && \
    chmod +x /usr/bin/brook
## Install brook
## Start service
brook wsserver --listen :${PORT} --password ${passwd}
