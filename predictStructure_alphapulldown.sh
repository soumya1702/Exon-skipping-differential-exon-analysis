#!/bin/bash
## to compute necessary features for the two proteins in AlphaPulldown
## Usage sbatch computeFeatures.sh 
## author - Sandali Lokuge

#SBATCH -J AlphaPulldown_structurePrediction
#SBATCH -p gpu
#SBATCH --account r00102
#SBATCH -e log_err.txt
#SBATCH -o log_out.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --gpus-per-node v100:1
#SBATCH --time=2-00:00:00
#SBATCH --mem=64G

module load anaconda/python3.8/2020.07 
module load cudatoolkit/11.7
conda activate /N/slate/sdlokuge/PP-Interaction/AlphaPulldown

MAXRAM=$(echo `ulimit -m` '/ 1024.0'|bc)
GPUMEM=`nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits|tail -1`
export XLA_PYTHON_CLIENT_MEM_FRACTION=`echo "scale=3;$MAXRAM / $GPUMEM"|bc`
export TF_FORCE_UNIFIED_MEMORY='1'

run_multimer_jobs.py \
    --mode=pulldown \
    --num_cycle=3 \
    --num_predictions_per_model=1 \
    --output_path=/N/u/sdlokuge/Carbonate/Documents/Genomics_data_analysis/project/Structure_prediction \
    --data_dir=/N/scratch/sdlokuge/AlphaFold_databases \
    --protein_lists=/N/u/sdlokuge/Carbonate/Documents/Genomics_data_analysis/project/baits.txt,/N/u/sdlokuge/Carbonate/Documents/Genomics_data_analysis/project/candidates.txt \
    --monomer_objects_dir=/N/u/sdlokuge/Carbonate/Documents/Genomics_data_analysis/project/All_prot_features \



    
