#!/usr/bin/env bash
#SBATCH -A C3SE2024-2-16
#SBATCH -t 00:30:00
#SBATCH -n 1
#SBATCH -c 30
#SBATCH --job-name=QC_trimmed
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

CONTAINER=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/project_container.sif

WORK_DIR=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/

#TEMP_DIR=$TMPDIR/JOB_TMP;

module purge

#mkdir $TEMP_DIR


# FastQC, then MultiQC for quality reports
# fetch files from project directory and store in a list.


apptainer exec $CONTAINER fastqc -t 30 -o $WORK_DIR/FastQC_result_Posttrim/ \
 TrimGalore_result/*.fq.gz

apptainer exec $CONTAINER multiqc -o MultiQC_result_posttrim/ $WORK_DIR/FastQC_result_Posttrim/*fastqc.zip

