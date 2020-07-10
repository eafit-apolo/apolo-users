#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=03:00:00
#SBATCH --output=TEannot-scheduler.stdout
#SBATCH --job-name="Sched_TEannot"
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

echo "DELETE FROM jobs WHERE groupid LIKE '${ProjectName}_%';" | \
mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB

# Submit jobs to SLURM
jid_step1=$(sbatch \
    --kill-on-invalid-dep=yes \
    TEannot_Step1.sh | \
    cut -d" " -f4)

jid_step2=$(sbatch \
    --kill-on-invalid-dep=yes \
    --dependency=afterok:$jid_step1 \
    --array=1-$(($NUM_ALIGNERS * 2)) \
    TEannot_Step2.sh | \
    cut -d" " -f4)

jid_step3=$(sbatch \
    --kill-on-invalid-dep=yes \
    --dependency=afterok:$jid_step2 \
    TEannot_Step3.sh | \
    cut -d" " -f4)

jid_step4=$(sbatch \
    --kill-on-invalid-dep=yes \
    --dependency=afterok:$jid_step1 \
    --array=0-$(( $NUM_SSR_DETECTORS - 1 )) \
    TEannot_Step4.sh | \
    cut -d" " -f4)

jid_step5=$(sbatch \
    --kill-on-invalid-dep=yes \
    --dependency=afterok:$jid_step4 \
    TEannot_Step5.sh | \
    cut -d" " -f4)

jid_step6=$(sbatch \
    --kill-on-invalid-dep=yes \
    --dependency=afterok:$jid_step1 \
    --array=0-1 \
    TEannot_Step6.sh | \
    cut -d" " -f4)

jid_step7=$(sbatch \
    --kill-on-invalid-dep=yes \
    --dependency=afterok:$jid_step3:$jid_step5:$jid_step6 \
    TEannot_Step7.sh | \
    cut -d" " -f4)

#jid_step8=$(sbatch \
#    --kill-on-invalid-dep=yes \
#    --dependency=afterok:$jid_step7 \
#    TEannot_Step8.sh | \
#    cut -d" " -f4)

echo "Finished submitting all jobs at $(date)"
