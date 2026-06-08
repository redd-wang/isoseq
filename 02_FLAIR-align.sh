#!/bin/bash

#SBATCH --job-name=FLAIR-align
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --array=0-3
#SBATCh --mail-user=rwang4@fredhutch.org
#SBATCH --mail-type=END
#SBATCH --output=FLAIR-align.txt

set -euo pipefail

##define files list
FILES=(fastq/*.fastq)
CURRENT_FILE=${FILES[$SLURM_ARRAY_TASK_ID]}
SAMPLE=$(basename "$CURRENT_FILE" .fastq)

module load FLAIR

echo "processing $SAMPLE"
mkdir -p align
flair align \
-g /shared/biodata/reference/iGenomes/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa \
-r "$CURRENT_FILE" \
-o align/${SAMPLE}.aligned \
-t 16




