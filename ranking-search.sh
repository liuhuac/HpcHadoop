#!/bin/bash

#PBS -q workq
#PBS -N ir8811
#PBS -l select=8:ncpus=8:mem=20gb:interconnect=mx,walltime=00:30:00
#PBS -k oe

### Run the myHadoop environment script to set the appropriate variables
#
# Note: ensure that the variables are set correctly in bin/setenv.sh
qstat -xf $PBS_JOBID >> /home/$USER/myHadoop-palmetto/nodeids.txt
. /home/$USER/myHadoop-palmetto/bin/setenv.sh

#### Set this to the directory where Hadoop configs should be generated
# Don't change the name of this variable (HADOOP_CONF_DIR) as it is
# required by Hadoop - all config files will be picked up from here
#
# Make sure that this is accessible to all nodes
export HADOOP_CONF_DIR="$MY_HADOOP_HOME/config"

#### Set up the configuration
# Make sure number of nodes is the same as what you have requested from PBS
# usage: $MY_HADOOP_HOME/bin/pbs-configure.sh -h
echo "Set up the configurations for myHadoop"
# this is the non-persistent mode
$MY_HADOOP_HOME/bin/pbs-configure.sh -n 8 -c $HADOOP_CONF_DIR
# this is the persistent mode
# $MY_HADOOP_HOME/bin/pbs-configure.sh -n 4 -c $HADOOP_CONF_DIR -p -d /oasis/cloudstor-group/HDFS
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
echo "Run some test Hadoop jobs"

#copy files to HDFS
        $HADOOP_PREFIX/bin/hadoop --config $HADOOP_CONF_DIR fs -mkdir /user/$USER/Data

        $HADOOP_PREFIX/bin/hadoop --config $HADOOP_CONF_DIR fs -copyFromLocal /home/$USER/ranking-index/* /user/$USER/Data
        $HADOOP_PREFIX/bin/hadoop --config $HADOOP_CONF_DIR fs -lsr /
        echo "copy input files"



#run IR jobs
        $HADOOP_PREFIX/bin/hadoop --config $HADOOP_CONF_DIR jar $HADOOP_PREFIX/ranking-search.jar ParserPackage.IRSearcher /user/${USER}/Data/ /user/${USER}/outputs world AND cup AND champion 

#copy hadoop logs to local directory
        $HADOOP_PREFIX/bin/hadoop fs -copyToLocal /user/${USER}/outputs/ /home/$USER/ranking-output2
#remove output  data
        $HADOOP_PREFIX/bin/hadoop fs -rmr /user/${USER}/*


echo
$HADOOP_PREFIX/bin/hadoop --config $HADOOP_CONF_DIR fs -lsr /
echo

#### Stop the Hadoop cluster
echo "Stop all Hadoop daemons"
$HADOOP_PREFIX/bin/stop-all.sh --config $HADOOP_CONF_DIR
echo

#### Clean up the working directories after job completion
echo "Clean up"
$MY_HADOOP_HOME/bin/pbs-cleanup.sh -n 8
echo
