#!/bin/bash

#run IR jobs
echo "run search job"
$HADOOP_PREFIX/bin/hadoop --config $HADOOP_CONF_DIR jar $HADOOP_PREFIX/IR.jar edu.clemson.inforetrieval.search.Searcher /user/${USER}/Index/ /user/${USER}/Search world AND cup AND champion 

#copy hadoop logs to local directory
#$HADOOP_PREFIX/bin/hadoop fs -copyToLocal /user/${USER}/outputs/ /home/$USER/ranking-output2
