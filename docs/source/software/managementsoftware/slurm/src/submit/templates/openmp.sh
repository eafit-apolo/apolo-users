#!/bin/bash

#SBATCH --job-name=openmp_test      # Job name
#SBATCH --mail-type=FAIL,END        # Mail notification
#SBATCH --mail-user=<user>@<domain> # User Email
#SBATCH --output=slurm-omp.%j.out   # Stdout (%j expands to jobId)
#SBATCH --error=slurm-omp.%j.err    # Stderr (%j expands to jobId)
#SBATCH --time=01:00                # Walltime
#SBATCH --partition=longjobs        # Partition
#SBATCH --ntasks=1                  # Number of tasks (processes)
#SBATCH --cpus-per-task=16          # Number of threads per task (Cronos-longjobs)


##### ENVIRONMENT CREATION #####
module load intel/18.0.1


##### JOB COMMANDS ####
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

./hello_omp_intel_cronos
