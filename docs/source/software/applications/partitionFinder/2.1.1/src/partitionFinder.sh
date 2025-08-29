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

module load python
source activate partitionFinder

##### JOB COMMANDS ####
/path/to/partition/finder/PartitionFinder.py /path/to/partitionFinder/input/files
