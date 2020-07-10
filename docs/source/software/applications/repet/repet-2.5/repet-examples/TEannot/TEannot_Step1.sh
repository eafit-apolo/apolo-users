#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=03:00:00
#SBATCH --output=TEannot-step1.stdout
#SBATCH --job-name="S1_TEannot"
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
source activate <YOUR_PYTHON_ENV>

# repet-examples TEannot - Step 1
# Prepare data banks for next steps

if  [ ! -n "" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

# if re-running step, drop MySQL tables
MYSQL_HOST=$(grep "repet_host" TEannot.cfg | cut -d" " -f2)
MYSQL_USER=$(grep "repet_user" TEannot.cfg | cut -d" " -f2)
MYSQL_PASS=$(grep "repet_pw" TEannot.cfg | cut -d" " -f2)
MYSQL_DB=$(grep "repet_db" TEannot.cfg | cut -d" " -f2)

echo "DROP TABLE IF EXISTS ${ProjectName}_chr_seq;" \
"DROP TABLE IF EXISTS ${ProjectName}_chk_seq;" \
"DROP TABLE IF EXISTS ${ProjectName}_chk_map;" \
"DROP TABLE IF EXISTS ${ProjectName}_refTEs_seq;" \
"DROP TABLE IF EXISTS ${ProjectName}_refTEs_map;" | \
mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB

TEannot.py -P $ProjectName  -C TEannot.cfg -S 1
