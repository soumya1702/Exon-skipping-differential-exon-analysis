#!/bin/bash
#SBATCH -J rna_trimmed
#SBATCH -p general
#SBATCH -o trimmed_sample.txt
#SBATCH -e trimmed_sample.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=syennapu@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=22:00:00
#SBATCH --mem=100G
#SBATCH -A students

# Set the path to the trim_galore executable (adjust as needed)
module load python/3.9.8
module load fastqc
module load trimgalore

# Directory where your FASTQ files are located
INPUT_DIR="/N/scratch/syennapu/GENOMICS_PROJECT/data"

# Loop through the FASTQ files and apply trim_galore
for R1 in "$INPUT_DIR"/*_1.fastq.gz; do
    R2="${R1/_1.fastq.gz/_2.fastq.gz}"  # Get the corresponding R2 file
    OUTPUT_DIR=$(dirname "$R1")/trimmed  # Output directory
    BASENAME=$(basename "$R1" _1.fastq.gz)  # File basename

    # Create the output directory if it doesn't exist
    mkdir -p "$OUTPUT_DIR"

    # Run trim_galore
    trim_galore --paired --clip_R1 12 --clip_R2 12 --three_prime_clip_R1 2 --three_prime_clip_R2 2 -o "$OUTPUT_DIR" "$R1" "$R2"
done

