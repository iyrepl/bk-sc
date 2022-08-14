FROM debian:latest
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install ssh wget git unzip screen gcc libpcre3-dev libssl-dev make tor supervisor -y
COPY brook /usr/local/bin/brook
RUN wget https://github.com/gitiy1/nginxbbr/raw/main/zlib-1.2.12.tar.gz && \
    tar -zxvf zlib-1.2.12.tar.gz && \
    wget https://nginx.org/download/nginx-1.22.0.tar.gz && \
    tar -zxvf nginx-1.22.0.tar.gz && \
    cd nginx-1.22.0 && \
    ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-http_sub_module --with-zlib=../zlib-1.2.12 && \
    make -j4 && \
    make install && \
    useradd www && \
    chown -Rf www:www /usr/local/nginx/ && \
    mkdir /var/log/nginx  && \
    echo 'echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf  && \
    echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf  && \
    sysctl -p  && \
    echo -e "BBR启动成功!"' && \
    chmod +x /usr/local/bin/brook 
RUN nohup /usr/bin/tor &
RUN nohup /usr/local/bin/brook wsserver --listen :1080 --path /iyreplsc233 --password iyreplsc233 &
COPY nginx.conf /usr/local/nginx/conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 80
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh
CMD /opt/entrypoint.sh
