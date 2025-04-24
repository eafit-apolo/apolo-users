#!/bin/bash

#SBATCH --job-name=edge_pro_test
#SBATCH --output=edge_pro_%A_%a.out
#SBATCH --error=edge_pro_%A_%a.err
#SBATCH --time=2:00
#SBATCH --partition=longjobs
#SBATCH --cpus-per-task=32

######################
# Begin work section #
######################

# Load module in default version
module load edge_pro

# Export number of threads
OMP_NUM_THREADS=32

edge.pl -g Cjejuni.fa -p Cjejuni.ptt -r Cjejuni.rnt -u wild1.fastq -s /share/apps/edge_pro/1.3.1/intel-2017_update-1/scripts -t 32
