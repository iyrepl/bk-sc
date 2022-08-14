FROM alpine

ENV PORT        3000
ENV PASSWORD    iyreplsc233

RUN URL="$(wget -qO- https://api.github.com/repos/txthinking/brook/releases/latest | grep -E "browser_download_url.*brook_linux_amd64" | cut -f4 -d\")" && \
    wget -O /usr/bin/brook $URL && \
    chmod +x /usr/bin/brook

CMD brook wsserver -l :$PORT  --path /iyreplsc233 -p $PASSWORD
