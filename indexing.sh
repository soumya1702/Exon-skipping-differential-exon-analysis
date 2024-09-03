#!/bin/bash

#SBATCH -J indexing
#SBATCH -p general
#SBATCH -o indexing.txt
#SBATCH -e indexing.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=syennapu@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=24:00:00
#SBATCH --mem=64G
#SBATCH -A students


module load star

GENOMEDIR="/N/scratch/syennapu/GENOMICS_PROJECT/"
mkdir -p $GENOMEDIR/indexingfiles
echo "$NOW1 STAR: Generate Genome Index 1"
echo "======================================"

STAR --runThreadN 12 --runMode genomeGenerate --genomeDir $GENOMEDIR/indexingfiles --genomeFastaFiles $GENOMEDIR/GRCh38.p14.genome.fa --sjdbGTFfile $GENOMEDIR/gencode.v44.chr_patch_hapl_scaff.annotation.gtf --sjdbOverhang 86

echo "======================================"
