#!/usr/bin/env bash
#SBATCH -A C3SE2024-2-16
#SBATCH -t 02:00:00
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --job-name=Counting
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

CONTAINER=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/project_container.sif

WORK_DIR=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/

apptainer exec $CONTAINER featureCounts -T 16 -p -t exon -g gene_id -a $WORK_DIR/Annotations/concat.gtf -o last_counts.txt $WORK_DIR/Bam_files/*.bam
