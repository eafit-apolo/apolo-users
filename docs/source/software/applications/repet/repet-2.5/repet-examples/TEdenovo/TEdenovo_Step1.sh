#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=03:00:00
#SBATCH --output=TEdenovo-step1.stdout
#SBATCH --job-name="S1_TEdenovo"
#SBATCH --partition longjobs

# Set project-specific variables
export ProjectName=$(grep "project_name" TEdenovo.cfg | cut -d" " -f2)
# (!) modify these to your project/environment
## (only choose what repet-examples supports)
export SMPL_ALIGNER="Blaster"
export CLUSTERERS_AVAIL="Grouper,Recon,Piler"
export MLT_ALIGNER="Map"
export FINAL_CLUSTERER="Blastclust"

# CLUSTERERS_AVAIL has to be a string because bash arrays cannot be passed
# directly to SLURM jobs; so the string is split into an array here and
# also in step scripts that need it
IFS=',' read -ra CLUSTERERS_AVAIL_ARRAY <<< "$CLUSTERERS_AVAIL"
# ${#CLUSTERERS_AVAIL_ARRAY[@]} gives length of CLUSTERERS_AVAIL_ARRAY array
NUM_CLUSTERERS=${#CLUSTERERS_AVAIL_ARRAY[@]}

module load REPET
source activate <YOUR_CONDA_ENV>

# repet-examples TEdenovo - Step 1
# Genomic sequence split into batches

#if  [ ! -n "" ]; then
#    echo 'One or more environment variables required by this script' \
#    'are unset. Either run this script through the scheduler script or' \
#    'set the variable(s) and use the --export option of sbatch before' \
#    'restarting.'
#    exit 1
#fi

if [ ! -d "_db" ]; then
    TEdenovo.py -P $ProjectName  -C ./TEdenovo.cfg -S 1
else
    echo "Step 1 output folder detected, skipping..."
fi
