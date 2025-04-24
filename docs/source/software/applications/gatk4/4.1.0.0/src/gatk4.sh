#!/bin/sh

#SBATCH --partition=longjobs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=05:00
#SBATCH --job-name=gatk_example
#SBATCH -o gatk4_%j.out
#SBATCH -e gatk4_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=youremail@email.com

# Don't share environment variables

module load gatk4/4.1.0.0

gatk PathSeqPipelineSpark \
    --input test_sample.bam \
    --filter-bwa-image hg19mini.fasta.img \
    --kmer-file hg19mini.hss \
    --min-clipped-read-length 70 \
    --microbe-fasta e_coli_k12.fasta \
    --microbe-bwa-image e_coli_k12.fasta.img \
    --taxonomy-file e_coli_k12.db \
    --output output.pathseq.bam \
    --scores-output output.pathseq.txt
