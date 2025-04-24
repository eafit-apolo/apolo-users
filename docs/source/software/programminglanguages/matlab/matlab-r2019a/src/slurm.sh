#!/bin/bash

#SBATCH -J test_matlab
#SBATCH -o test_matlab-%j.out
#SBATCH -e test_matlab-%j.err
#SBATCH -p bigmem
#SBATCH -n 8
#SBATCH -t 20:00

module load matlab/r2018a

matlab -nosplash -nodesktop < parallel_example_unattended.m
