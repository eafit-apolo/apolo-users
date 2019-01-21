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

export SBATCH_EXPORT=NONE
export OMP_NUM_THREADS=1

mafft --quiet --auto --thread $SLURM_NTASKS example.fa > example_al.fa
