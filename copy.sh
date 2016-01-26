#!/bin/bash

#copy files to HDFS
$HADOOP_PREFIX/bin/hadoop --config $HADOOP_CONF_DIR fs -mkdir /user/$USER/Data
$HADOOP_PREFIX/bin/hadoop --config $HADOOP_CONF_DIR fs -copyFromLocal /home/$USER/InfoRe/tmp/* /user/$USER/Data
echo "copy input files"

