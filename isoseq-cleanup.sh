#!/bin/bash

#SBATCH --job-name=isoseq-cleanup
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCh --mail-user=rwang4@fredhutch.org
#SBATCH --mail-type=END
#SBATCH --output=cleanup.txt

set -euo pipefail

module load SAMtools

mkdir -p unalignedBAM
echo "merge two runs' unaligned BAMs together"

samtools merge -o unalignedBAM/FGC.bam \
../../klevine2_collab/PB1358_for_Nelson_lab/cell_1/flnc-1.bam \
../../klevine2_collab/PB1358_for_Nelson_lab/cell_2/flnc-1.bam
samtools merge -o unalignedBAM/35CR.bam \
../../klevine2_collab/PB1358_for_Nelson_lab/cell_1/flnc-2.bam \
../../klevine2_collab/PB1358_for_Nelson_lab/cell_2/flnc-2.bam
samtools merge -o unalignedBAM/35CS.bam \
../../klevine2_collab/PB1358_for_Nelson_lab/cell_1/flnc-3.bam \
../../klevine2_collab/PB1358_for_Nelson_lab/cell_2/flnc-3.bam
samtools merge -o unalignedBAM/189-4.bam \
../../klevine2_collab/PB1358_for_Nelson_lab/cell_1/flnc-4.bam \
../../klevine2_collab/PB1358_for_Nelson_lab/cell_2/flnc-4.bam

echo "reverse unaligned BAM files to fastq"
mkdir -p fastq
samtools fastq unalignedBAM/FGC.bam > fastq/FGC.fastq
samtools fastq unalignedBAM/35CR.bam > fastq/35CR.fastq
samtools fastq unalignedBAM/35CS.bam > fastq/35CS.fastq
samtools fastq unalignedBAM/189-4.bam > fastq/189-4.fastq
