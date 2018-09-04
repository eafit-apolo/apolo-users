#!/bin/bash
#SBATCH --partition=longjobs
#SBATCH --job-name=bayescan_test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=30:00
#SBATCH --output=bayescan_test%j.slurm.log

# Load module for default version
module load bayescan

bayscan -snp ~/bayescan/BayeScan2.1/input_examples/test_genotype_SNP.txt -all_trace -out_prilot pilot
