#!/bin/bash

#SBATCH --job-name=mpi_test         # Job name
#SBATCH --mail-type=FAIL,END        # Mail notification
#SBATCH --mail-user=<user>@<domain> # User Email
#SBATCH --output=slurm-mpi.%j.out   # Stdout (%j expands to jobId)
#SBATCH --error=slurm-mpi.%j.err    # Stderr (%j expands to jobId)
#SBATCH --time=01:00                # Walltime
#SBATCH --partition=longjobs        # Partition
#SBATCH --ntasks=5                  # Number of tasks (processes)
#SBATCH --ntasks-per-node=1         # Number of task per node (machine)


##### ENVIRONMENT CREATION #####
module load impi


##### JOB COMMANDS ####
srun --mpi=pmi2 ./mpi_hello_world_apolo
