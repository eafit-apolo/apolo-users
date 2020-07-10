#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=03:00:00
#SBATCH --output=TEdenovo-step5.stdout
#SBATCH --job-name="S5_TEdenovo"
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

# repet-examples TEdenovo - Step 5 - Combined Standard and Structural
# Features detected on each consensus (structural or homology-based)

if  [ ! -n "" ] || [ ! -n "$CLUSTERERS_AVAIL" ] || [ ! -n "$SMPL_ALIGNER" ] || [ ! -n "$MLT_ALIGNER" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

if [ ! -d "${ProjectName}_${SMPL_ALIGNER}_${CLUSTERERS}_Struct_${MLT_ALIGNER}_TEclassif/detectFeatures" ]; then
    # if re-running step, drop MySQL tables
    MYSQL_HOST=$(grep "repet_host" TEdenovo.cfg | cut -d" " -f2)
    MYSQL_USER=$(grep "repet_user" TEdenovo.cfg | cut -d" " -f2)
    MYSQL_PASS=$(grep "repet_pw" TEdenovo.cfg | cut -d" " -f2)
    MYSQL_DB=$(grep "repet_db" TEdenovo.cfg | cut -d" " -f2)

    echo "DROP TABLE IF EXISTS ${ProjectName}_TE_BLRn_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_TE_BLRtx_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_TE_BLRx_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_TR_set;" \
    "DROP TABLE IF EXISTS ${ProjectName}_SSR_set;" \
    "DROP TABLE IF EXISTS ${ProjectName}_polyA_set;" \
    "DROP TABLE IF EXISTS ${ProjectName}_ORF_map;" \
    "DROP TABLE IF EXISTS ${ProjectName}_RepbaseNT_seq;" \
    "DROP TABLE IF EXISTS ${ProjectName}_RepbaseAA_seq;" \
    "DROP TABLE IF EXISTS ${ProjectName}_HG_BLRn_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_rDNA_BLRn_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_tRNA_map;" \
    "DROP TABLE IF EXISTS ${ProjectName}_Profiles_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_ProfilesDB_map;" | \
    mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB

    CLUSTERERS=$( echo $CLUSTERERS_AVAIL | tr -d ',' )

    #TEdenovo.py -P $ProjectName  -C TEdenovo.cfg -S 5 -s Blaster -c GrpRecPil -m Map
    TEdenovo.py -P $ProjectName  -C TEdenovo.cfg -S 5 -s Blaster -c GrpRecPil -m Map --struct
else
    echo "Step 5 output folder detected, skipping..."
fi
