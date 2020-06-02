#!/bin/bash
# Put your SLURM options here
#SBATCH --time=00:02:00           # put proper time of reservation here
#SBATCH --nodes=1                 # number of nodes
#SBATCH --ntasks-per-node=8       # processes per node
#SBATCH --job-name=parallel_example     # change to your job name
#SBATCH --output=parallel_example.%j.out # Stdout (%j expands to jobId)
#SBATCH --error=parallel_example.%j.err # Stderr (%j expands to jobId)

module load dmtcp

source coordinator.sh

export OMP_NUM_THREADS=8

################################################################################
# 1. Start DMTCP coordinator
################################################################################

start_coordinator -i 35


################################################################################
# 2. Launch application
################################################################################

dmtcp_launch --rm  ./parallel_example
