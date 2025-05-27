#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodes=1                
#SBATCH --job-name=eval_all
#SBATCH --output=slurm_eval_array.%j.out
#SBATCH --partition=gpu
#SBATCH --mem=4G                
#SBATCH --constraint=avx2
#SBATCH --mail-user=n.dat@outlook.com
#SBATCH --mail-type=ALL


module load BCFtools/1.10.2-GCC-8.3.0
module load Nextflow/21.03
module load singularity/rpm

# bcftools +fill-tags ${vcf_file} -- -t AF | \
# bcftools query -f '%ID\\t%INFO/AF\\n' | \
# awk '{maf = ($2 <= 0.5 ? $2 : 1-$2); print $1, maf}'

## set up tools
export NXF_SINGULARITY_CACHEDIR=/mnt/users/ngda/sofware/singularity
export TOWER_ACCESS_TOKEN=<your_tower_access_token_here>

chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
random_chars=$(printf "%s" "${chars:RANDOM%${#chars}:1}${chars:RANDOM%${#chars}:1}")
#echo "$random_chars"


nextflow run main_array.nf \
    -name eval_array_ALL_${random_chars} \
    --batch_dir "/mnt/ScratchProjects/dat_projects/lps_analysis/imputed_array" \
    --true_vcfs "/mnt/ScratchProjects/dat_projects/igsr_data/ac_filtered/*vcf.gz" \
    -w work_eval_array_ALL \
    -resume \
    -profile cluster \
    -with-tower
#

