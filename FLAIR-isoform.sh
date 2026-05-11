#!/bin/bash

#SBATCH --job-name=FLAIR-isoform
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --array=0-3
#SBATCH --mail-user=rwang4@fredhutch.org
#SBATCH --mail-type=END
#SBATCH --output=FLAIR-isoform_%a.txt

set -euo pipefail

##define files list
FILES=(align/*.bam)
CURRENT_FILE=${FILES[$SLURM_ARRAY_TASK_ID]}
SAMPLE=$(basename "$CURRENT_FILE" .bam)

module load Miniforge3
source /home/rwang4/.bashrc
conda activate flair3

## calling all high confidence isoforms
echo "processing $SAMPLE for the high confidence isoforms"
mkdir -p isoform
flair transcriptome \
-g /shared/biodata/reference/iGenomes/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa \
-f /shared/biodata/reference/iGenomes/Homo_sapiens/UCSC/hg38/Annotation/Genes/genes.gtf \
-b "$CURRENT_FILE" \
-o "isoform/${SAMPLE}" \
-t 16

conda deactivate
conda deactivate
