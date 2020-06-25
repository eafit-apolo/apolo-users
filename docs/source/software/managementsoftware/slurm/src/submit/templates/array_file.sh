#!/bin/bash

#SBATCH --job-name=array_file_test       # Job name
#SBATCH --mail-type=FAIL,END             # Mail notification
#SBATCH --mail-user=<user>@<domain>      # User Email
#SBATCH --output=slurm-arrayJob%A_%a.out # Stdout (%a expands to stepid, %A to jobid )
#SBATCH --error=slurm-array%J.err        # Stderr (%J expands to GlobalJobid)
#SBATCH --ntasks=1                       # Number of tasks (processes) for each array-job
#SBATCH --time=01:00                     # Walltime for each array-job
#SBATCH --partition=debug                # Partition

#SBATCH --array=0-4    # Array index


##### ENVIRONMENT CREATION #####


##### JOB COMMANDS ####

# Array of files
files=(./test/*)

# Work based on the SLURM_ARRAY_TASK_ID
srun cp ${files[$SLURM_ARRAY_TASK_ID]} copy_$SLURM_ARRAY_TASK_ID
