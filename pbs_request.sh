#!/bin/bash -xv

#PBS -N hadoop-cluster
#PBS -l select=4:ncpus=1:mem=15gb:interconnect=mx:chip_type=2356,walltime=5:00:00
#PBS -k oe

cd $PBS_O_WORKDIR

echo "test!!!!!!!!!!!!!!!!!!"
#./pbs-interactive.sh
