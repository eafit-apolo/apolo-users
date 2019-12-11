#!/bin/bash
#SBATCH --job-name=wps-wrf                      # Job name
#SBATCH --mail-type=ALL                         # Mail notification
#SBATCH --mail-user=<user>@<domain>             # User Email
#SBATCH --error=%x-%j.err                       # Stderr (%j expands to jobId)
#SBATCH --output=%x-%j.out                      # Stdout (%j expands to jobId)
#SBATCH --ntasks=2                              # Number of tasks (processes)
#SBATCH --nodes=1                               # Number of nodes
#SBATCH --time=3:00:00                          # Walltime
#SBATCH --partition=longjobs                    # Partition

##### MODULES #####

module load namd/2.13-gcc_CUDA

namd2 ubq_ws_eq.conf