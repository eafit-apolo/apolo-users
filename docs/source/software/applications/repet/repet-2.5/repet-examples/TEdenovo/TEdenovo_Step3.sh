#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=03:00:00
#SBATCH --output=TEdenovo-step3-%a.stdout
#SBATCH --job-name="S3_TEdenovo"
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

# repet-examples TEdenovo - Step 3
# HSP clustering by Recon, Grouper, and/or Piler

if  [ ! -n "" ] || [ ! -n "$CLUSTERERS_AVAIL" ] || [ ! -n "$SMPL_ALIGNER" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

# split CLUSTERERS_AVAIL string into bash array
IFS=',' read -ra CLUSTERERS_AVAIL_ARRAY <<< "$CLUSTERERS_AVAIL"
CLUSTERER=${CLUSTERERS_AVAIL_ARRAY[$SLURM_ARRAY_TASK_ID]}

if [ ! -d "${ProjectName}_${SMPL_ALIGNER}_${CLUSTERER}" ]; then
    TEdenovo.py -P $ProjectName  -C TEdenovo.cfg -S 3 -s $SMPL_ALIGNER -c Grouper
    TEdenovo.py -P $ProjectName  -C TEdenovo.cfg -S 3 -s $SMPL_ALIGNER -c Recon
    TEdenovo.py -P $ProjectName  -C TEdenovo.cfg -S 3 -s $SMPL_ALIGNER -c Piler
else
    echo "Step 3 output folder detected, skipping..."
fi
