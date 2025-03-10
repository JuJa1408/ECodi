#!/usr/bin/env bash
#SBATCH -A C3SE2024-2-16
#SBATCH -t 00:30:00
#SBATCH -n 1
#SBATCH -c 8
#SBATCH --job-name=Indexing
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

CONTAINER=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/project_container.sif

WORK_DIR=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/

module purge

apptainer exec $CONTAINER STAR --runMode genomeGenerate --genomeDir genomeDir \
 --genomeFastaFiles Reference_genomes/concatenated_genomes.fasta --sjdbGTFfile Annotations/concat.gtf \
 --genomeSAindexNbases 14 --runThreadN 8
