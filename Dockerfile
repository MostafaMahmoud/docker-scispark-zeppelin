FROM pymonger/scispark-zeppelin:latest

# Zeppelin
ENV ZEPPELIN_PORT 8080
ENV ZEPPELIN_HOME /usr/zeppelin
ENV ZEPPELIN_CONF_DIR $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook

# add startup script
COPY start-scispark.sh /root/start-scispark.sh
RUN set -ex \
 && chmod 755 /root/start-scispark.sh

WORKDIR /root
CMD ["./start-scispark.sh"]
