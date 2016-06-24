#!/bin/bash

# start sshd for HDFS
/usr/sbin/sshd
sleep 10

# start HDFS
/usr/hadoop-2.6.3/sbin/start-dfs.sh
sleep 10

# start Zeppelin
/usr/zeppelin/bin/zeppelin.sh
