#!/bin/bash

#SBATCH --job-name=FLAIR-align-T2T
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --array=0-3
#SBATCh --mail-user=rwang4@fredhutch.org
#SBATCH --mail-type=END
#SBATCH --output=FLAIR-align_%a.txt

set -euo pipefail

##define files list
FILES=(fastq/*.fastq)
CURRENT_FILE=${FILES[$SLURM_ARRAY_TASK_ID]}
SAMPLE=$(basename "$CURRENT_FILE" .fastq)

module load FLAIR

echo "processing $SAMPLE"
mkdir -p alignT2T
flair align \
-g /shared/biodata/reference/iGenomes/Homo_sapiens/UCSC/T2T-CHM13/Sequence/WholeGenomeFasta/genome.fa \
-r "$CURRENT_FILE" \
-o alignT2T/${SAMPLE} \
-t 8




