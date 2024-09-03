#!/bin/sh
## to compute necessary features for the proteins in AlphaPulldown
## Usage sbatch computeFeatures.sh 
## author - Sandali Lokuge

#SBATCH -J AlphaPulldown_computeFeatures
#SBATCH -p gpu
#SBATCH --account r00102
#SBATCH -e err_log.txt
#SBATCH -o out_log.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --gpus-per-node v100:1
#SBATCH --time=2-00:00:00
#SBATCH --mem=64G


module load anaconda/python3.8/2020.07 
conda activate /N/slate/sdlokuge/PP-Interaction/AlphaPulldown

create_individual_features.py \
    --fasta_paths=/N/u/sdlokuge/Carbonate/Documents/Genomics_data_analysis/project/seq_file.fasta \
    --data_dir=/N/scratch/sdlokuge/AlphaFold_databases/ \
    --save_msa_files=False \
    --output_dir=/N/u/sdlokuge/Carbonate/Documents/Genomics_data_analysis/project/All_prot_features \
    --use_precomputed_msas=False \
    --max_template_date=2050-01-01 \
    --skip_existing=False \
