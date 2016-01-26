#!/bin/bash

#run IR jobs
echo "run indexing job"
$HADOOP_PREFIX/bin/hadoop --config $HADOOP_CONF_DIR jar $HADOOP_PREFIX/IR.jar edu.clemson.inforetrieval.reverseindex.ReverseIndex /user/${USER}/Data/ /user/${USER}/Index
