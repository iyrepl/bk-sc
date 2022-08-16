FROM iyserver/bbase:latest
COPY zlib-1.2.12.tar.gz /root
WORKDIR /root
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install wget git unzip gcc libpcre3-dev libssl-dev libpcre3 libperl-dev zlib1g-dev make build-essential supervisor tor -y
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh
RUN cd /root && \
    tar -zxvf zlib-1.2.12.tar.gz && \
    git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module.git && \
    wget https://nginx.org/download/nginx-1.22.0.tar.gz && \
    tar -zxvf nginx-1.22.0.tar.gz && \
    cd nginx-1.22.0 && \
    ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_realip_module --with-http_ssl_module --with-http_gzip_static_module --with-http_perl_module --with-http_sub_module --with-zlib=../zlib-1.2.12 --add-module=../ngx_http_substitutions_filter_module && \
    make -j4&& \
    make install && \
    useradd www && \
    chown -Rf www:www /usr/local/nginx/ && \
    mkdir /var/log/nginx  && \
    mkdir -p /ngcache  && \
    chown -R www:www /ngcache && \
    echo 'echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf  && \
    echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf  && \
    sysctl -p  && \
    echo -e "BBR启动成功！"'
ADD nginx.conf /usr/local/nginx/conf 
EXPOSE 80
CMD ["sh", "-c", "/opt/entrypoint.sh"]
ENTRYPOINT [ "/usr/local/nginx/sbin/nginx", "-g", "daemon off;" ]
