#!/usr/bin/env bash
#SBATCH -A C3SE2024-2-16
#SBATCH -t 02:00:00
#SBATCH -n 1
#SBATCH -c 30
#SBATCH --job-name=QC
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

CONTAINER=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/project_container.sif

WORK_DIR=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/

#TEMP_DIR=$TMPDIR/JOB_TMP;

module purge

#mkdir $TEMP_DIR


# FastQC, then MultiQC for quality reports
# fetch files from project directory and store in a list.

apptainer exec $CONTAINER fastqc -t 30 -o $WORK_DIR/FastQC_result/ \
 /cephyr/NOBACKUP/groups/bbt045_2025/Projects/Data/RNAseq/*.fastq.gz

apptainer exec $CONTAINER multiqc -o MultiQC_result/ $WORK_DIR/FastQC_result/*fastqc.zip



