#!/usr/bin/env bash
#SBATCH -A C3SE2024-2-16
#SBATCH -t 00:20:00
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

#FILE_LIST=`ls $WORK_DIR/TrimGalore_result/ERR950162_1_val_1.fq.gz | sed "s/_1_val_1.fq.gz//"`

# Mapping to reference genome with STAR. Looping through files, using basename to get rid of the path and keeping the id


id=$(basename $WORK_DIR/TrimGalore_result/ERR950162_1_val_1.fq.gz)

echo "Running STAR for sample: ERR950162"
apptainer exec $CONTAINER STAR --runThreadN 32 --genomeDir $WORK_DIR/genomeDir \
 --readFilesIn $WORK_DIR/TrimGalore_result/ERR950162_1_val_1.fq.gz $WORK_DIR/TrimGalore_result/ERR950162_2_val_2.fq.gz\
 --outFileNamePrefix ./ --readFilesCommand gunzip -c

# saving files in bam format

apptainer exec $CONTAINER samtools view -b -S -o $WORK_DIR/Bam_files_result/${id}.bam $WORK_DIR/Aligned.out.sam

apptainer exec $CONTAINER samtools sort $WORK_DIR/Bam_files_result/*.bam -o $WORK_DIR/Bam_files_result/


# samtools and Qualimap for post-alignment quality control

# featureCounts for counting mapped reads

# DESeq2 or edgeR for differential expression analysis
# Done in R

# GOseq, clusterProfiler and/or GSEA for Gene Ontology analysis and KEGG pathway enrichment

# ggplot2, pheatmap and/or PCAtools for volcano plots, heatmaps and PCA plots

# Annotate reference genome

# Generate counts
