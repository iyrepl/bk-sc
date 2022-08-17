FROM debian:latest
#COPY zlib-1.2.12.tar.gz /root
#WORKDIR /root
#RUN apk update
#RUN apk add --no-cache ca-certificates openssl-dev iotop libgcc libc-dev libcurl libc-utils pcre-dev zlib-dev libnfs pcre pcre2 zip net-tools pstree libevent libevent-dev iproute2 wget git unzip gcc make supervisor tor sudo
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install wget git unzip gcc libpcre3-dev libssl-dev libpcre3 libperl-dev zlib1g-dev make build-essential supervisor tor sudo -y
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh
#ADD nginx.conf /usr/local/nginx/conf 
#CMD [bash /opt/entrypoint.sh]
EXPOSE 1080
ENTRYPOINT ["sh", "-c", "/opt/entrypoint.sh"]
