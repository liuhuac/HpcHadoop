#!/bin/bash

# Uncomment the following line to enable shell debugging
set -x

# Set this to the location of Java JRE on compute nodes. 
export JAVA_HOME=`echo $(dirname $(dirname $(which java)))`

# Set this to location of myHadoop 
export MY_HADOOP_PREFIX="/home/$USER/Softwares/myHadoop"

# Set this to the location of the Hadoop installation
export HADOOP_PREFIX="/home/$USER/Softwares/hadoop-1.2.1"

# Set this to the location you want to use for HDFS
# Note that this path should point to a LOCAL directory, and
# that the path should exist on all slave nodes
export HADOOP_DATA_DIR="/tmp/hadoop-$USER/data"

# Set this to the location where you want the Hadoop logfies
export HADOOP_LOG_DIR="/tmp/hadoop-$USER/log"

