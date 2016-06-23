FROM pymonger/scispark-zeppelin:v0.2_000

# Zeppelin
ENV ZEPPELIN_PORT 8080
ENV ZEPPELIN_HOME /usr/zeppelin
ENV ZEPPELIN_CONF_DIR $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook

#ADD about.json $ZEPPELIN_NOTEBOOK_DIR/2BH1SW5AH/note.json
WORKDIR /root
CMD ["./start-scispark.sh"]
