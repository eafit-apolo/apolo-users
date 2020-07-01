#!/bin/bash

#SBATCH --job-name=gmx-GPU
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=4
#SBATCH --time=10:00:00
#SBATCH --partition=accel-2
#SBATCH --gres=gpu:2
#SBATCH --output=gmx-GPU.%j.out
#SBATCH --error=gmx-GPU.%j.err

module load gromacs/2019.3_intel-17_cuda-9.0

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

gmx grompp -f step6.0_minimization.mdp -o step6.0_minimization.tpr -c step5_charmm2gmx.pdb -r step5_charmm2gmx.pdb -p topol.top
gmx mdrun -v -deffnm step6.0_minimization -ntmpi $SLURM_NTASKS -ntomp $SLURM_CPUS_PER_TASK -gpu_id 01

# Equilibration
cnt=1
cntmax=6

while [ $cnt -le $cntmax ]; do
    pcnt=$((cnt-1))
    if [ $cnt -eq 1 ]; then
	gmx grompp -f step6.${cnt}_equilibration.mdp -o step6.${cnt}_equilibration.tpr -c step6.${pcnt}_minimization.gro -r step5_charmm2gmx.pdb -n index.ndx -p topol.top
        gmx mdrun -v -deffnm step6.${cnt}_equilibration -ntmpi $SLURM_NTASKS -ntomp $SLURM_CPUS_PER_TASK -gpu_id 01
    else
	gmx grompp -f step6.${cnt}_equilibration.mdp -o step6.${cnt}_equilibration.tpr -c step6.${pcnt}_equilibration.gro -r step5_charmm2gmx.pdb -n index.ndx -p topol.top
        gmx mdrun -v -deffnm step6.${cnt}_equilibration -ntmpi $SLURM_NTASKS -ntomp $SLURM_CPUS_PER_TASK -gpu_id 01
    fi
    ((cnt++))
done

# Production
cnt=1
cntmax=10

while [ $cnt -le $cntmax ]; do
    if [ $cnt -eq 1 ]; then
        gmx grompp -f step7_production.mdp -o step7_${cnt}.tpr -c step6.6_equilibration.gro -n index.ndx -p topol.top
        gmx mdrun -v -deffnm step7_${cnt} -ntmpi $SLURM_NTASKS -ntomp $SLURM_CPUS_PER_TASK -gpu_id 01
    else
	pcnt=$((cnt-1))
	gmx grompp -f step7_production.mdp -o step7_${cnt}.tpr -c step7_${pcnt}.gro -t step7_${pcnt}.cpt -n index.ndx -p topol.top
        gmx mdrun -v -deffnm step7_${cnt} -ntmpi $SLURM_NTASKS -ntomp $SLURM_CPUS_PER_TASK -gpu_id 01
    fi
    ((cnt++))
done
