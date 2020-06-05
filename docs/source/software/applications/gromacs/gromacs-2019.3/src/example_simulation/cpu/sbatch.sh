#!/bin/bash

################################################################################
################################################################################
#
# Find out the density of TIP4PEW water.
# How to run the simulation was taken from:
# https://www.svedruziclab.com/tutorials/gromacs/1-tip4pew-water/
#
################################################################################
################################################################################

#SBATCH --job-name=gmx-CPU
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=16
#SBATCH --time=03:00:00
#SBATCH --partition=longjobs
#SBATCH --output=gmx-CPU.%j.out
#SBATCH --error=gmx-CPU.%j.err
#SBATCH --mail-user=example@eafit.edu.co
#SBATCH --mail-type=END,FAIL

module load gromacs/2016.4_gcc-5.5.0

# Create box of water.
gmx_mpi solvate -cs tip4p -o conf.gro -box 2.3 2.3 2.3 -p topol.top

# Minimizations.
gmx_mpi grompp -f mdp/min.mdp -o min -pp min -po min
srun --mpi=pmi2 gmx_mpi mdrun -deffnm min

gmx_mpi grompp -f mdp/min2.mdp -o min2 -pp min2 -po min2 -c min -t min
srun --mpi=pmi2 gmx_mpi mdrun -deffnm min2

# Equilibration 1.
gmx_mpi grompp -f mdp/eql.mdp -o eql -pp eql -po eql -c min2 -t min2
srun --mpi=pmi2 gmx_mpi mdrun -deffnm eql

# Equilibration 2.
gmx_mpi grompp -f mdp/eql2.mdp -o eql2 -pp eql2 -po eql2 -c eql -t eql
srun --mpi=pmi2 gmx_mpi mdrun -deffnm eql2

# Production.
gmx_mpi grompp -f mdp/prd.mdp -o prd -pp prd -po prd -c eql2 -t eql2
srun --mpi=pmi2 gmx_mpi mdrun -deffnm prd
