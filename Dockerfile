FROM alpine:latest
COPY zlib-1.2.12.tar.gz /root
WORKDIR /root
RUN apk update
RUN apk install -y wget git unzip gcc libpcre3-dev libssl-dev libpcre3 libperl-dev zlib1g-dev make build-essential supervisor tor sudo
#RUN apt update
#RUN DEBIAN_FRONTEND=noninteractive apt install wget git unzip gcc libpcre3-dev libssl-dev libpcre3 libperl-dev zlib1g-dev make build-essential supervisor tor sudo -y
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh
RUN cd /root && \
    wget https://nginx.org/download/nginx-1.22.0.tar.gz && \
    tar -zxvf zlib-1.2.12.tar.gz && \
    tar -zxvf nginx-1.22.0.tar.gz && \
    cd nginx-1.22.0 && \
    ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-http_sub_module --with-zlib=../zlib-1.2.12 && \
    make -j4 && \
    make install && \
    useradd www && \
    chown -Rf www:www /usr/local/nginx/ && \
    echo 'echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf  && \
    echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf  && \
    sysctl -p  && \
    echo -e "BBR启动成功！"'
ADD nginx.conf /usr/local/nginx/conf 
#CMD [bash /opt/entrypoint.sh]
EXPOSE 80
ENTRYPOINT ["sh", "-c", "/opt/entrypoint.sh"]
