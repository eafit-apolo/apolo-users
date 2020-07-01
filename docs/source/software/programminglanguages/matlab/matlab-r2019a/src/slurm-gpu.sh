#!/bin/bash

#SBATCH -J test_matlab
#SBATCH -o test_matlab-gpu-%j.out
#SBATCH -e test_matlab-gpu-%j.err
#SBATCH -p accel
#SBATCH -n 1
#SBATCH -t 20:00
#SBATCH --gres=gpu:2
 
module load matlab/r2018a

matlab -nosplash -nodesktop < gpu_script.m

