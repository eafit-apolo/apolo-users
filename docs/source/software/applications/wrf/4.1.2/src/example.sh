#!/bin/bash

#SBATCH --partition=longjobs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --time=120:00:00
#SBATCH --job-name=test
#SBATCH -o result_%N_%j.out      # File to which STDOUT will be written
#SBATCH -e result_%N_%j.err      # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user=test@example.com

module load wrf/4.1.2_intel-17.0.1
mpirun -np $SLURM_NTASKS real.exe