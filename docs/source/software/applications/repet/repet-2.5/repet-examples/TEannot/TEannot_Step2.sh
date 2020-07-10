#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=03:00:00
#SBATCH --output=TEannot-step2-%a.stdout
#SBATCH --job-name="S2_TEannot"
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

export ALIGNERS_AVAIL="BLR+RM"

module load REPET
source activate <YOUR_CONDA_ENV>

# repet-examples TEannot - Step 2
# Align reference TEs to genome

if  [ ! -n "" ] || [ ! -n "$ALIGNERS_AVAIL" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

OUT_DIR="${ProjectName}_TEdetect"
CMD_SUFFIX=""
#elif [ "$(( $SLURM_ARRAY_TASK_ID % 2 ))" -eq "1" ]; then
#    OUT_DIR="${ProjectName}_TEdetect_rnd"
#    CMD_SUFFIX="-r"

IFS='+' read -ra ALIGNERS_AVAIL_ARRAY <<< "${ALIGNERS_AVAIL}"
NUM_ALIGNERS=${#ALIGNERS_AVAIL_ARRAY[@]}
ALIGNER=BLR

if [ ! -d "${OUT_DIR}/${ALIGNER}" ]; then
    TEannot.py -P $ProjectName  -C TEannot.cfg -S 2 -a BLR
else
    echo "Step 2 output folder detected, skipping..."
fi
