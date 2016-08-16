#!/bin/bash


#Copy ESIP workshop notebooks
rm -rf /usr/zeppelin/notebook/*
mkdir -p /tmp/notebooks
git clone https://github.com/SciSpark/scispark_zeppelin_notebooks /tmp/notebooks
for i in /tmp/notebooks/workshop*/*; do cp -r $i /usr/zeppelin/notebook/; done


#Mount S3
s3fs scispark-workshop /mnt/s3 -o passwd_file=/home/passwd.txt


#Start sshd for HDFS
/usr/sbin/sshd
sleep 5


#Start HDFS
/usr/hadoop-2.6.3/sbin/start-dfs.sh
sleep 10


#Remove old data
hdfs dfsadmin -safemode leave
hdfs dfs -rmr /data/*
hdfs dfs -rmr /data


#Copy SciSpark JAR file from S3 to local and set the Zeppelin parameters
mkdir /home/workshop
cp -r /mnt/s3/scispark_jar /home/workshop


#Configure Zeppelin with SciSpark JAR file
export ZEPPELIN_JAVA_OPTS="-Dspark.jars=/home/workshop/scispark_jar/SciSpark.jar -Dspark.executor.memory=6g"
export SPARK_SUBMIT_OPTIONS="--jars /home/workshop/scispark_jar/SciSpark.jar --driver-java-options -Xmx20g"
export ZEPPELIN_WEBSOCKET_MAX_TEXT_MESSAGE_SIZE=1048576


#Copy data from S3 to local and Hadoop and local
hdfs dfs -mkdir /workshop_s3
hdfs dfs -mkdir /workshop_s3/101
hdfs dfs -copyFromLocal /mnt/s3/data/101/* /workshop_s3/101
hdfs dfs -mkdir /workshop_s3/201
hdfs dfs -mkdir /workshop_s3/201/merg
hdfs dfs -copyFromLocal /mnt/s3/data/201/merg* /workshop_s3/201/merg
hdfs dfs -mkdir /workshop_s3/201/trmm
hdfs dfs -copyFromLocal /mnt/s3/data/201/3B42* /workshop_s3/201/trmm
hdfs dfs -mkdir /workshop_s3/301
hdfs dfs -mkdir /workshop_s3/301/pdf_clustering
hdfs dfs -copyFromLocal /mnt/s3/data/301/pdf_clustering/* /workshop_s3/301/

cp -r /mnt/s3/data/201/viz_data /home/workshop
cp -r /mnt/s3/data/TRMM_daily /home/workshop
cp -r /mnt/s3/data/301/pdf_clustering /home/workshop
cp -r /mnt/s3/data/301/CMDA /home/workshop


#Copy and setup anaconda
cd /usr
cp -r /mnt/s3/anaconda.tar.gz ./
tar -xvzf anaconda.tar.gz
rm -rf anaconda2
rm -rf anaconda.tar.gz
mv anaconda anaconda2


#Give access to local files
chmod -R 777 /home/workshop

#Remove passwd.txt file
rm /home/passwd.txt


#Start Zeppelin
/usr/zeppelin/bin/zeppelin.sh