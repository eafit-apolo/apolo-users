#!/bin/bash

#SBATCH -J test_matlab
#SBATCH -o test_matlab.out
#SBATCH -e test_matlab.err
#SBATCH -p longjobs
#SBATCH -n 8
#SBATCH -t 20:00
 
module load matlab/r2018a

matlab -nosplash -nodesktop -r "matlab_batch"
