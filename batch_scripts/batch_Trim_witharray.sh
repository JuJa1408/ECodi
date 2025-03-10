#!/usr/bin/env bash
#SBATCH -A C3SE2024-2-16
#SBATCH -t 02:00:00
#SBATCH -n 1
#SBATCH --job-name=QC_trimming
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

CONTAINER=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/project_container.sif

WORK_DIR=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/

echo "trim_galore --fastqc_args --paired $i\_1.fastq.gz $i\_2.fastq.gz + more arguments... "
apptainer exec $CONTAINER trim_galore --quality 20 --length 50 \
 -o $WORK_DIR/TrimGalore_result2 --paired /cephyr/NOBACKUP/groups/bbt045_2025/Projects/Data/RNAseq/ERR9501${SLURM_ARRAY_TASK_ID}_1.fastq.gz \
 /cephyr/NOBACKUP/groups/bbt045_2025/Projects/Data/RNAseq/ERR9501${SLURM_ARRAY_TASK_ID}_2.fastq.gz
done

