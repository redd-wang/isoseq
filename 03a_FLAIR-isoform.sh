#!/bin/bash

#SBATCH --job-name=FLAIR-isoform
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --array=0-3
#SBATCH --mail-user=rwang4@fredhutch.org
#SBATCH --mail-type=END
#SBATCH --output=FLAIR-isoforms_%a.txt

set -euo pipefail

##define files list
FILES=(alignT2T/*.bam)
CURRENT_FILE=${FILES[$SLURM_ARRAY_TASK_ID]}
SAMPLE=$(basename "$CURRENT_FILE" .bam)
JUNCTION_TAB="/home/rwang4/peteslab/Redd/isoseq/SJ/${SAMPLE}.tab"

module load Miniforge3
source /home/rwang4/.bashrc
conda activate flair3

## calling all high confidence isoforms
echo "processing $SAMPLE for the high confidence isoforms"
mkdir -p isoform
flair transcriptome \
    -g /shared/biodata/reference/iGenomes/Homo_sapiens/UCSC/T2T-CHM13/Sequence/WholeGenomeFasta/genome.fa \
    -f /home/rwang4/peteslab/Redd/reference/chm13/chm13v2.0_RefSeq_v5.2.gtf \
    -b "$CURRENT_FILE" \
    -o "isoform/${SAMPLE}" \
    --junction_tab "$JUNCTION_TAB" \
    -t 16 \
    
conda deactivate
conda deactivate

    