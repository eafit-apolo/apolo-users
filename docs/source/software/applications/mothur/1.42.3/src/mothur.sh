#!/bin/bash

#SBATCH --job-name=serial_test       # Job name
#SBATCH --mail-type=ALL         # Mail notification
#SBATCH --mail-user=<user>@<domain>  # User Email
#SBATCH --output=mothur-%j.out # Stdout (%j expands to jobId)
#SBATCH --error=mothur-%j.err  # Stderr (%j expands to jobId)
#SBATCH --ntasks=1                   # Number of tasks (processes)
#SBATCH --time=01:00                 # Walltime
#SBATCH --partition=longjobs         # Partition


##### ENVIRONMENT CREATION #####

module load mothur/1.42.1_intel-2017_update-1

##### JOB COMMANDS ####

mothur "#read.dist(phylip=98_sq_phylip_amazon.dist, cutoff=0.1); cluster(); collect.single(); rarefaction.single()"
