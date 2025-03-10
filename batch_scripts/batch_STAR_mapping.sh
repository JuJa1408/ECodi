#!/usr/bin/env bash
#SBATCH -A C3SE2024-2-16
#SBATCH -t 05:00:00
#SBATCH -n 1
#SBATCH -c 32
#SBATCH --job-name=mapping
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

CONTAINER=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/project_container.sif

WORK_DIR=/cephyr/NOBACKUP/groups/bbt045_2025/groups/group_Ecodi/

#TEMP_DIR=$TMPDIR/JOB_TMP;

module purge

#mkdir $TEMP_DIR


# FastQC, then MultiQC for quality reports
# fetch files from project directory and store in a list.

FILE_LIST=`ls $WORK_DIR/TrimGalore_result2/*_1_val_1.fq.gz | sed "s/_1_val_1.fq.gz//"`

# Mapping to reference genome with STAR. Looping through files, using basename to get rid of the path and keeping the id

for i in $FILE_LIST
do

id=$(basename $i)

echo "Running STAR for sample: $i"
apptainer exec $CONTAINER STAR --runThreadN 32 --genomeDir $WORK_DIR/genomeDir \
 --readFilesIn ${i}_1_val_1.fq.gz ${i}_2_val_2.fq.gz\
 --outFileNamePrefix $WORK_DIR/Sam_files/${id} --readFilesCommand gunzip -c

# saving files in bam format

apptainer exec $CONTAINER samtools view -b -S -o $WORK_DIR/Bam_files/${id}.bam $WORK_DIR/Sam_files/${id}
done

