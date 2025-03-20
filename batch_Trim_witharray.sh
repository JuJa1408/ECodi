#!/usr/bin/env bash
#SBATCH -A C3SE2024-2-16
#SBATCH -t 02:00:00
#SBATCH -n 1
#SBATCH --job-name=QC_trimming
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

#CONTAINER=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/project_container.sif
CONTAINER=./project_container.sif

#WORK_DIR=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/
WORK_DIR=.

module purge

#Trimming with minimum quality score of 20 and minimum length 50 bp

echo "trim_galore --paired *_1.fastq.gz *_2.fastq.gz -o $WORK_DIR/TrimGalore_result "
apptainer exec $CONTAINER trim_galore --quality 20 --length 50 \
 -o $WORK_DIR/TrimGalore_result --paired /cephyr/NOBACKUP/groups/bbt045_2025/Projects/Data/RNAseq/ERR9501${SLURM_ARRAY_TASK_ID}_1.fastq.gz \
 /cephyr/NOBACKUP/groups/bbt045_2025/Projects/Data/RNAseq/ERR9501${SLURM_ARRAY_TASK_ID}_2.fastq.gz


