FROM alpine

ENV PORT        3000
ENV PASSWORD    iyreplsc233

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh
ENTRYPOINT ["sh", "-c", "/opt/entrypoint.sh"]
