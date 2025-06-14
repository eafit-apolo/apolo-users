#!/bin/bash

#SBATCH --partition=learning                   # Partition
#SBATCH --nodes=1
#SBATCH --ntasks=4                            # Number of tasks (processes)
#SBATCH --time=1:00:00                            # Walltime
#SBATCH --job-name=test_ORCA                    # Job name
#SBATCH --output=%x_%j.out                      # Stdout (%x-jobName, %j-jobId)
#SBATCH --error=%x_%j.err                       # Stderr (%x-jobName, %j-jobId)
#SBATCH --mail-type=ALL                         # Mail notification
#SBATCH --mail-user=your_user@eafit.edu.co       # User Email

##### ENVIRONMENT CREATION #####
module load orca


##### JOB COMMANDS ####
$(which orca) ./water-parallel.inp
