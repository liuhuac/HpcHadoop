#!/bin/bash -xv

N_OF_NODES=`awk 'END { print NR }' $PBS_NODEFILE`
$MY_HADOOP_PREFIX/bin/pbs-configure.sh -n $N_OF_NODES -c $HADOOP_CONF_DIR

# this is the persistent mode
# $BUILDER_HOME/myHadoop/bin/pbs-configure.sh -n $N_OF_NODES -c $HADOOP_CONF_DIR -p -d /oasis/cloudstor-group/HDFS
echo

#### Format HDFS, if this is the first time or not a persistent instance
echo "Format HDFS"
$HADOOP_PREFIX/bin/hadoop --config $HADOOP_CONF_DIR namenode -format
echo
#### Start the Hadoop cluster
echo "Start all Hadoop daemons"
$HADOOP_PREFIX/bin/start-all.sh --config $HADOOP_CONF_DIR
#$HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave
echo

#### Run your jobs here
echo "Hadoop is configured successful"
echo "Run some test Hadoop jobs"
