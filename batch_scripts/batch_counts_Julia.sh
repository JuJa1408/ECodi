#!/usr/bin/env bash
#SBATCH -A C3SE2024-2-16
#SBATCH -t 01:00:00
#SBATCH -n 1
#SBATCH -c 5
#SBATCH --job-name=Counting
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

CONTAINER=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/project_container.sif

WORK_DIR=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/

apptainer exec $CONTAINER featureCounts -T 8 -p -t exon -g gene_id -a Annotations/concat.gtf -o counts2.txt $WORK_DIR/Bam_files_result/*.bam
