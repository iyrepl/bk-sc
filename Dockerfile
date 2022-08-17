FROM debian:latest
WORKDIR /root
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install wget git unzip gcc libpcre3-dev libssl-dev libpcre3 libperl-dev zlib1g-dev make build-essential supervisor tor -y
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh
EXPOSE 1080
ENTRYPOINT ["sh", "-c", "/opt/entrypoint.sh"]
