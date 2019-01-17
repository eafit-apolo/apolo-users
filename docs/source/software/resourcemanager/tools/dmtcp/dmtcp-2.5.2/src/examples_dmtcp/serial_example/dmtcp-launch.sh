#!/bin/bash
# Put your SLURM options here
#SBATCH --time=00:30:00           # put proper time of reservation here
#SBATCH --nodes=1                 # number of nodes
#SBATCH --ntasks-per-node=1       # processes per node
#SBATCH --job-name=serial_example     # change to your job name
#SBATCH --output=serial_example.%j.out # Stdout (%j expands to jobId)
#SBATCH --error=serial_example.%j.err # Stderr (%j expands to jobId)

module load dmtcp

source coordinator.sh

################################################################################
# 1. Start DMTCP coordinator
################################################################################

start_coordinator -i 35


################################################################################
# 2. Launch application
################################################################################

dmtcp_launch --rm  ./serial_example
