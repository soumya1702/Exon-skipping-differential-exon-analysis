#!/bin/bash
#SBATCH -J filtering
#SBATCH -p general
#SBATCH -o filtering_reads.txt
#SBATCH -e filtering_reads.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=syennapu@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=84:00:00
#SBATCH --mem=80G
#SBATCH -A students
# Set the path to the ngsutilsj executable
NGSUTILSJ_PATH="/N/scratch/syennapu/GENOMICS_PROJECT/ngsutilsj/dist/ngsutilsj"

# Set the input directory
INPUT_DIR="/N/scratch/syennapu/GENOMICS_PROJECT/mapping"

# Set the output directory
OUTPUT_DIR="/N/scratch/syennapu/GENOMICS_PROJECT/filtering_reads"

# Loop through all BAM files in the input directory
for bam_file in ${INPUT_DIR}/*.bam; do
    # Extract the file name without extension
    base_name=$(basename -- "$bam_file")
    file_name="${base_name%.*}"

    # Define the output file path
    output_file="${OUTPUT_DIR}/${file_name}_filtered.bam"

    # Run the ngsutilsj command for each BAM file
    ${NGSUTILSJ_PATH} bam-filter --mapped --no-qcfail --tag-min MAPQ:10 "${bam_file}" "${output_file}"
done

