#!/bin/bash

#SBATCH --job-name=array_params_test     # Job name
#SBATCH --mail-type=FAIL,END             # Mail notification
#SBATCH --mail-user=<user>@<domain>      # User Email
#SBATCH --output=slurm-arrayJob%A_%a.out # Stdout (%a expands to stepid, %A to jobid )
#SBATCH --error=slurm-array%J.err        # Stderr (%J expands to GlobalJobid)
#SBATCH --ntasks=1                       # Number of tasks (processes) for each array-job
#SBATCH --time=01:00                     # Walltime for each array-job
#SBATCH --partition=debug                # Partition

#SBATCH --array=0-3    # Array index
#SBATCH --exclusive    # Force slurm to use 4 different nodes

##### ENVIRONMENT CREATION #####


##### JOB COMMANDS ####

# Array of params
params=(0.05 100 999 1295.5)

# Work based on the SLURM_ARRAY_TASK_ID
srun echo ${params[$SLURM_ARRAY_TASK_ID]}
