#!/bin/bash
#SBATCH --job-name=LAMMPS_Bench
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --partition=longjobs
#SBATCH --time=01:00:00
#SBATCH -o results_%j.out
#SBATCH -e results_%j.err

export OMP_NUM_THREADS=1

module load lammps

export WDIR=<REPO_DIR>/bench

srun --mpi=pmi2 lammps -in $WDIR/in.lj
srun --mpi=pmi2 lammps -in $WDIR/in.chain
srun --mpi=pmi2 lammps -in $WDIR/in.eam
srun --mpi=pmi2 lammps -in $WDIR/in.chute
srun --mpi=pmi2 lammps -in $WDIR/in.rhodo
