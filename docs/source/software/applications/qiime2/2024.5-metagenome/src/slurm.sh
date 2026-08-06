#!/bin/bash

SBATCH --partition=learning                     # Partition
SBATCH --nodes=3
SBATCH --ntasks=1                               # Number of tasks (processes)
SBATCH --time=1:00:00                           # Walltime
SBATCH --job-name=<job_name>                    # Job name
SBATCH --output=%x_%j.out                       # Stdout (%x-jobName, %j-jobId)
SBATCH --error=%x_%j.err                        # Stderr (%x-jobName, %j-jobId)
SBATCH --mail-type=ALL                          # Mail notification
SBATCH --mail-user=youremail@eafit.edu.co       # User Email


##### ENVIRONMENT CREATION #####
module load python
source activate qiime2-metagenome-2024.5


##### JOB COMMANDS ####
#3. Sequence quality control and feature table construction
qiime <plugin> <flags>
