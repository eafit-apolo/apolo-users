#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=03:00:00
#SBATCH --output=TEannot-step6-%a.stdout
#SBATCH --job-name="S6_TEannot"
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

# repet-examples TEannot - Step 6
# Align RepBase databanks to genome

LOCAL_ALIGNERS=("blastx" "tblastx")
LOCAL_ALIGNER_ABRS=("x" "tx")
LOCAL_ALIGNER=${LOCAL_ALIGNERS[$SLURM_ARRAY_TASK_ID]}
LCL_ALN=${LOCAL_ALIGNER_ABRS[$SLURM_ARRAY_TASK_ID]}

if [ $SLURM_ARRAY_TASK_ID -eq '0' ]; then
    OUT_DIR="${ProjectName}_TEdetect/bankBLRx"
elif [ $SLURM_ARRAY_TASK_ID -eq '1' ]; then
    OUT_DIR="${ProjectName}_TEdetect/bankBLRtx"
else
    echo "SLURM array improperly set up"
    exit 1
fi

if [ ! -d "${ProjectName}_TEdetect/bankBLR${LCL_ALN}" ]; then
    # if re-running step, drop MySQL tables
    MYSQL_HOST=$(grep "repet_host" TEannot.cfg | cut -d" " -f2)
    MYSQL_USER=$(grep "repet_user" TEannot.cfg | cut -d" " -f2)
    MYSQL_PASS=$(grep "repet_pw" TEannot.cfg | cut -d" " -f2)
    MYSQL_DB=$(grep "repet_db" TEannot.cfg | cut -d" " -f2)

    echo "DROP TABLE IF EXISTS ${ProjectName}_chk_bankBLR${LCL_ALN}_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_chr_bankBLR${LCL_ALN}_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_bankBLR${LCL_ALN}_nt_seq;" \
    "DROP TABLE IF EXISTS ${ProjectName}_bankBLR${LCL_ALN}_prot_seq;" | \
    mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB

    TEannot.py -P $ProjectName  -C TEannot.cfg -S 6 -b $LOCAL_ALIGNER
else
    echo "Step 6 output folder detected, skipping..."
fi
