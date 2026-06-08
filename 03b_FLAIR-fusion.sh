#!/bin/bash

#SBATCH --job-name=FLAIR-fusion
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --array=0-3
#SBATCH --mail-user=rwang4@fredhutch.org
#SBATCH --mail-type=END
#SBATCH --output=FLAIR-fusion_%a.txt

set -euo pipefail

##define files list
FILES=(alignT2T/*.bam)
CURRENT_FILE=${FILES[$SLURM_ARRAY_TASK_ID]}
SAMPLE=$(basename "$CURRENT_FILE" .bam)
FASTQ="/home/rwang4/peteslab/Redd/isoseq/fastq/${SAMPLE}.fastq"

module load Miniforge3
source /home/rwang4/.bashrc
conda activate flair3

##calling fusion transcripts
echo "processing $SAMPLE for the fusion transcripts"
mkdir -p fusion
flair fusion \
    -g /shared/biodata/reference/iGenomes/Homo_sapiens/UCSC/T2T-CHM13/Sequence/WholeGenomeFasta/genome.fa \
    -r "$FASTQ" \
    -b "$CURRENT_FILE" \
    -f /home/rwang4/peteslab/Redd/reference/chm13/chm13v2.0_RefSeq_v5.2.gtf \
    -o "fusion/${SAMPLE}"\
    -t 8

conda deactivate
conda deactivate
