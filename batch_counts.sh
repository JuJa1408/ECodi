#!/usr/bin/env bash
#SBATCH -A C3SE2024-2-16
#SBATCH -t 02:00:00
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --job-name=Counting
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

#CONTAINER=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/project_container.sif
CONTAINER=./project_container.sif

#WORK_DIR=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/
WORK_DIR=.

module purge

echo "apptainer exec $CONTAINER featureCounts -T 16 -p -t exon -g gene_id -a $WORK_DIR/Annotations/concat.gtf -o counts.txt $WORK_DIR/Bam_files/*.bam"
apptainer exec $CONTAINER featureCounts -T 16 -p -t exon -g gene_id -a $WORK_DIR/Annotations/concat.gtf -o counts.txt $WORK_DIR/Bam_files/*.bam

#Removing unnecessary columns and keeping only H. pylori counts. Saving data to HP_counts.txt
grep "^HP" counts.txt | cut -f 1,7-100 >HP_counts.txt
