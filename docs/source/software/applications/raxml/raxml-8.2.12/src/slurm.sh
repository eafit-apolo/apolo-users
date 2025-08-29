#!/bin/bash

#SBATCH --partition=longjobs
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=16
#SBATCH --time=48:00:00
#SBATCH --job-name=RAxML_test
#SBATCH -o result_%N_%j.out
#SBATCH -e result_%N_%j.err

# Default variables
export SBATCH_EXPORT=NONE
export OMP_NUM_THREADS=1

# Load RAxML module file
module load raxml/8.2.12_intel-17.0.1

# Launch RAxML (MPI with srun (pmi2) and PThreads using '-T' argument
# and SLURM_CPUS_PER_TASK environment variable.
srun --mpi=pmi2 raxmlHPC-HYBRID-AVX2 -s funiji.fasta -T $SLURM_CPUS_PER_TASK \
     -X -f a -n out_1 -m GTRGAMMA -x 6669 -p 2539 -N 100
