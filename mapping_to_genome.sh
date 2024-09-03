#!/bin/bash

#SBATCH -J mapping
#SBATCH -p general
#SBATCH -o mapping.txt
#SBATCH -e mapping.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=syennapu@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=84:00:00
#SBATCH --mem=80G
#SBATCH -A students

#loading star module
module load star
#loading python module
module load 'python/3.9.8'

#creating a new directory for output files
mkdir -p /N/scratch/syennapu/GENOMICS_PROJECT/mapping

GENOMEDIR="/N/scratch/syennapu/GENOMICS_PROJECT/"
FASTQ_FILES="/N/scratch/syennapu/GENOMICS_PROJECT/data/trimmed/"

for ((i=764; i<=828; i++)); do
  SAMPLE_NAME="SRR14136${i}"

  # Check if both input files exist
  if [[ ! -f "$FASTQ_FILES/${SAMPLE_NAME}_1_val_1.fq.gz" || ! -f "$FASTQ_FILES/${SAMPLE_NAME}_2_val_2.fq.gz" ]]; then
    echo "sample $SAMPLE_NAME does not exist"
    continue  # Skip the current iteration
  fi

  STAR --runThreadN 12 --genomeDir $GENOMEDIR/indexingfiles --readFilesIn $FASTQ_FILES/${SAMPLE_NAME}_1_val_1.fq.gz $FASTQ_FILES/${SAMPLE_NAME}_2_val_2.fq.gz \
      --readFilesCommand zcat \
      --quantMode GeneCounts \
      --outFileNamePrefix /N/scratch/syennapu/GENOMICS_PROJECT/mapping/${SAMPLE_NAME} --outSAMmapqUnique 60 --outSAMtype BAM SortedByCoordinate --outReadsUnmapped Fastx
done
