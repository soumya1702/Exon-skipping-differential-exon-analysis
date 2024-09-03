#!/bin/sh
## to execute featureCounts in subread package
## Usage sbatch featureCount.sh
## author - Sandali Lokuge

#SBATCH -A r00102
#SBATCH -J featurecounts
#SBATCH -p general
#SBATCH -o /N/scratch/syennapu/GENOMICS_PROJECT/featurecounts_log_out.txt
#SBATCH -e /N/scratch/syennapu/GENOMICS_PROJECT/featurecounts_error_out.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=4-00:00:00
#SBATCH --mem=32G

cd /N/project/wan_bioinfo/Sandali/RNAseq_analysis/subread-2.0.0-Linux-x86_64/bin/

#~ ./featureCounts -f -O -s 0 -p -T 20 -t exon \
#~ -F GTF -a /N/scratch/syennapu/GENOMICS_PROJECT/Subread_to_DEXSeq/filtered_gencode_v44_featurecounts.gtf \
#~ -o /N/scratch/syennapu/GENOMICS_PROJECT/featureCount_output/featurecounts.out \
#~ /N/scratch/syennapu/GENOMICS_PROJECT/filtering_reads/cancer/*Aligned.sortedByCoord.out_filtered.bam \
#~ /N/scratch/syennapu/GENOMICS_PROJECT/filtering_reads/normal/*Aligned.sortedByCoord.out_filtered.bam


./featureCounts -f -O -s 0 -p -T 20 -t exon \
-F GTF -a /N/scratch/syennapu/GENOMICS_PROJECT/Subread_to_DEXSeq/filtered_gencode_v44_featurecounts.gtf \
-o /N/scratch/syennapu/GENOMICS_PROJECT/featureCount_output/selectedSamples_featurecounts.out \
/N/scratch/syennapu/GENOMICS_PROJECT/filtering_reads/cancer/SRR14136797Aligned.sortedByCoord.out_filtered.bam \
/N/scratch/syennapu/GENOMICS_PROJECT/filtering_reads/cancer/SRR14136774Aligned.sortedByCoord.out_filtered.bam \
/N/scratch/syennapu/GENOMICS_PROJECT/filtering_reads/cancer/SRR14136786Aligned.sortedByCoord.out_filtered.bam \
/N/scratch/syennapu/GENOMICS_PROJECT/filtering_reads/cancer/SRR14136779Aligned.sortedByCoord.out_filtered.bam \
/N/scratch/syennapu/GENOMICS_PROJECT/filtering_reads/normal/SRR14136793Aligned.sortedByCoord.out_filtered.bam \
/N/scratch/syennapu/GENOMICS_PROJECT/filtering_reads/normal/SRR14136826Aligned.sortedByCoord.out_filtered.bam \
/N/scratch/syennapu/GENOMICS_PROJECT/filtering_reads/normal/SRR14136784Aligned.sortedByCoord.out_filtered.bam \
/N/scratch/syennapu/GENOMICS_PROJECT/filtering_reads/normal/SRR14136808Aligned.sortedByCoord.out_filtered.bam 
