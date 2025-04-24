#!/bin/bash

#SBATCH --job-name=serial_test       # Job name
#SBATCH --mail-type=FAIL,END         # Mail notification
#SBATCH --mail-user=<user>@<domain>  # User Email
#SBATCH --output=slurm-serial.%j.out # Stdout (%j expands to jobId)
#SBATCH --error=slurm-serial.%j.err  # Stderr (%j expands to jobId)
#SBATCH --ntasks=1                   # Number of tasks (processes)
#SBATCH --time=01:00                 # Walltime
#SBATCH --partition=longjobs         # Partition


##### ENVIRONMENT CREATION #####



##### JOB COMMANDS ####
hostname
date
sleep 50
