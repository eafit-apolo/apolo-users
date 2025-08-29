#!/bin/bash

#SBATCH --job-name=<job_name>       # Job name
#SBATCH --mail-type=ALL         # Mail notification
#SBATCH --mail-user=test@eafit.edu.co  # User Email
#SBATCH --output=%x.%j.out # Stdout (%j expands to jobId, %x expands to jobName)
#SBATCH --error=%x.%j.err  # Stderr (%j expands to jobId, %x expands to jobNam0e)
#SBATCH --ntasks=1                   # Number of tasks (processes)
#SBATCH --cpus-per-task=32           # Number of threads
#SBATCH --time=1-00:00               # Walltime
#SBATCH --partition=longjobs         # Partition


##### ENVIRONMENT CREATION #####
module load python
source activate qiime2-2019.7

##### JOB COMMANDS ####
#3. Sequence quality control and feature table construction
qiime <plugin> <flags>
