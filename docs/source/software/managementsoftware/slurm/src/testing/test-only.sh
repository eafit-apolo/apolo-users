#!/bin/bash

#SBATCH --job-name=test_only         # Job name
#SBATCH --ntasks=80                  # Number of tasks (processes)
#SBATCH --ntasks-per-node=16         # Maximum possible value in Cronos 
#SBATCH --time=01:00                 # Walltime
#SBATCH --partition=longjobs         # Partition

#SBATCH --test-only                  # Test the job


##### ENVIRONMENT CREATION #####



##### JOB COMMANDS ####
srun not_a_executable
