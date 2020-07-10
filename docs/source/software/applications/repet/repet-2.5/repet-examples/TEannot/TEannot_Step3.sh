#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=03:00:00
#SBATCH --output=TEannot-step3.stdout
#SBATCH --job-name="S3_TEannot"
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

# repet-examples TEannot Pipeline Scheduler

# Set project-specific variables
export ProjectName=$(grep "project_name" TEannot.cfg | cut -d" " -f2)
# (!) modify these to your project/environment
## (only choose what repet-examples supports)
export ALIGNERS_AVAIL="BLR+RM"
export SSR_DETECTORS_AVAIL="TRF+RMSSR"

# ALIGNERS_AVAIL has to be a string because bash arrays cannot be passed
# directly to SLURM jobs; so the string is split into an array here and
# also in step scripts that need it
IFS='+' read -ra ALIGNERS_AVAIL_ARRAY <<< "$ALIGNERS_AVAIL"
# ${#ALIGNERS_AVAIL_ARRAY[@]} gives length of ALIGNERS_AVAIL_ARRAY array
NUM_ALIGNERS=${#ALIGNERS_AVAIL_ARRAY[@]}

IFS='+' read -ra SSR_DETECTORS_AVAIL_ARRAY <<< "$SSR_DETECTORS_AVAIL"
NUM_SSR_DETECTORS=${#SSR_DETECTORS_AVAIL_ARRAY[@]}

# Clear the jobs table for the current project
## in case last run failed for some reason while sub-jobs were running
MYSQL_HOST=$(grep "repet_host" TEannot.cfg | cut -d" " -f2)
MYSQL_USER=$(grep "repet_user" TEannot.cfg | cut -d" " -f2)
MYSQL_PASS=$(grep "repet_pw" TEannot.cfg | cut -d" " -f2)
MYSQL_DB=$(grep "repet_db" TEannot.cfg | cut -d" " -f2)

module load REPET
source activate <YOUR_CONDA_ENV>

# repet-examples TEannot - Step 3
# Filter and combine HSPs from Step 2 alignment

if  [ ! -n "" ] || [ ! -n "$ALIGNERS_AVAIL" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

if [ ! -d "${ProjectName}_TEdetect/Comb" ]; then
    # if re-running step, drop MySQL tables
    MYSQL_HOST=$(grep "repet_host" TEannot.cfg | cut -d" " -f2)
    MYSQL_USER=$(grep "repet_user" TEannot.cfg | cut -d" " -f2)
    MYSQL_PASS=$(grep "repet_pw" TEannot.cfg | cut -d" " -f2)
    MYSQL_DB=$(grep "repet_db" TEannot.cfg | cut -d" " -f2)

    echo "DROP TABLE IF EXISTS ${ProjectName}_chk_allTEs_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_chr_allTEs_path;" | \
    mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB

    TEannot.py -P $ProjectName  -C TEannot.cfg -S 3 -c $ALIGNERS_AVAIL
else
    echo "Step 3 output folder detected, skipping..."
fi
