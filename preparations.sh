#!/bin/bash

#Creating necessary directories
mkdir Reference_genomes Annotations FastQC_result MultiQC_result TrimGalore_result FastQC_result_Posttrim MultiQC_result_posttrim genomeDir Sam_files Bam_files

#Get the genomes to the directory Reference_genomes
wget -O ./Reference_genomes/HP26695.fasta https://ftp.ensemblgenomes.ebi.ac.uk/pub/bacteria/release-60/fasta/bacteria_0_collection/helicobacter_pylori_26695_gca_000008525/dna/Helicobacter_pylori_26695_gca_000008525.ASM852v1.dna.toplevel.fa.gz
cp /cephyr/NOBACKUP/groups/bbt045_2025/Projects/Data/human_genome/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa ./Reference_genomes/Human_genome.fasta 

#Get the annotation files to the directory Annotations
wget -O ./Annotations/HP26695.gtf https://ftp.ensemblgenomes.ebi.ac.uk/pub/release-60/bacteria//gtf/bacteria_0_collection/helicobacter_pylori_26695_gca_000008525/Helicobacter_pylori_26695_gca_000008525.ASM852v1.60.gtf.gz
wget -O ./Annotations/Human_genome.gtf https://ftp.ensembl.org/pub/release-113/gtf/homo_sapiens/Homo_sapiens.GRCh38.113.gtf.gz

cat Reference_genomes/HP26695.fasta Reference_genomes/Human_genome.fasta | grep -v '^#' > Reference_genomes/concatenated_genomes.fasta
cat Annotations/HP26695.gtf Annotations/Human_genome.gtf | grep -v '^#' > Annotations/concat.gtf

#Downloading the project container and processing it
#wget -O ./project_container.def https://raw.githubusercontent.com/JuJa1408/ECodi/58cc01c68a83e803c5a073831909ca15dbf198e7/project_container.def
