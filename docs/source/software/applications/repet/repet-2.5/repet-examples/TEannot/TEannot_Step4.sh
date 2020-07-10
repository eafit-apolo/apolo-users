#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=03:00:00
#SBATCH --output=TEannot-step4-%a.stdout
#SBATCH --job-name="S4_TEannot"
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

# repet-examples TEannot - Step 4
# Search for satellites in the genomic sequence

IFS='+' read -ra SSR_DETECTORS_AVAIL_ARRAY <<< "${SSR_DETECTORS_AVAIL}"
SSR_DETECTOR=${SSR_DETECTORS_AVAIL_ARRAY[$SLURM_ARRAY_TASK_ID]}

if [ ! -d "${ProjectName}_SSRdetect/${SSR_DETECTOR}" ]; then
    TEannot.py -P $ProjectName  -C TEannot.cfg -S 4 -s $SSR_DETECTOR
else
    echo "Step 4 output folder detected, skipping..."
fi
