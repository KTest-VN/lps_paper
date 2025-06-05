#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodes=1                
#SBATCH --job-name=merge1-10
#SBATCH --output=slurm_merge1-10.%j.out
#SBATCH --partition=gpu
#SBATCH --mem=4G                
#SBATCH --constraint=avx2
#SBATCH --mail-user=n.dat@outlook.com
#SBATCH --mail-type=ALL


module load BCFtools/1.10.2-GCC-8.3.0
module load Nextflow/21.03
module load singularity/rpm



## set up tools
export NXF_SINGULARITY_CACHEDIR=/mnt/users/ngda/sofware/singularity
export TOWER_ACCESS_TOKEN=<your_tower_access_token_here>


chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
random_chars=$(printf "%s" "${chars:RANDOM%${#chars}:1}${chars:RANDOM%${#chars}:1}")

for BATCH in {1..10}
do
    nextflow run merge_mini_batches.nf \
        -name merge_${BATCH}_${random_chars} \
        --outdir /mnt/ScratchProjects/dat_projects/lps_analysis/merged_batch_lps/batch_${BATCH} \
        --mini1 /mnt/ScratchProjects/dat_projects/lps_analysis/imputed_lps/batch_${BATCH}_1 \
        --mini2 /mnt/ScratchProjects/dat_projects/lps_analysis/imputed_lps/batch_${BATCH}_2 \
        --mini3 /mnt/ScratchProjects/dat_projects/lps_analysis/imputed_lps/batch_${BATCH}_3 \
        --mini4 /mnt/ScratchProjects/dat_projects/lps_analysis/imputed_lps/batch_${BATCH}_4 \
        -w work_merge_${BATCH} \
        -resume \
        -profile cluster \
        -with-tower
done



