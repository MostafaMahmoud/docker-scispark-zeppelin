FROM pymonger/scispark-zeppelin:v0.3_004


RUN apt-get update && apt-get install -y automake \
    autotools-dev \
    g++ \
    libcurl4-gnutls-dev \
    libfuse-dev \
    libssl-dev \
    libxml2-dev \
    make \
    pkg-config \
    git \
    exfat-fuse \
    exfat-utils \
    curl \
    openjdk-7-jdk \
    maven


# Zeppelin
ENV ZEPPELIN_PORT 8080
ENV ZEPPELIN_HOME /usr/zeppelin
ENV ZEPPELIN_CONF_DIR $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook


# Mount S3
RUN echo <put access key for S3 here> > /home/passwd.txt
RUN chmod 400 /home/passwd.txt
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git
WORKDIR s3fs-fuse
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install
RUN mkdir -p /mnt/s3


#Change the Zeppelin skin
RUN mkdir -p ~/.m2/repository/org/apache/zeppelin/zeppelin-web/0.6.0-SNAPSHOT/
RUN cp /usr/zeppelin/zeppelin-web-0.6.0-SNAPSHOT.war ~/.m2/repository/org/apache/zeppelin/zeppelin-web/0.6.0-SNAPSHOT/
RUN mkdir -p /tmp/zeppelin_skin
RUN git clone -b zeppelin_0.6.0 https://github.com/SciSpark/scispark_zeppelin_web.git /tmp/zeppelin_skin
WORKDIR /tmp/zeppelin_skin
RUN mvn clean install -DskipTests
RUN cp ./target/zeppelin-web-0.6.0-SNAPSHOT.war /usr/zeppelin/


#Add startup script
COPY start-scispark.sh /root/start-scispark.sh
RUN set -ex \
 && chmod 755 /root/start-scispark.sh


#Start
WORKDIR /root
CMD ["./start-scispark.sh"]
